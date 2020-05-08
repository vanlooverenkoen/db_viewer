import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/repo/caching/caching_repository.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class MoorTableContentListViewerViewModel with ChangeNotifier {
  GeneratedDatabase _db;
  MoorTableViewerNavigator _navigator;
  TableInfo<moor.Table, DataClass> _table;
  final cachingRepo = CachingRepository.instance();

  final _data = List<Map<String, dynamic>>();
  FilterData _filteredData;

  int totalResults = 0;

  String error;

  StreamSubscription<List<QueryRow>> _subscriptionList;
  StreamSubscription<List<QueryRow>> _subscriptionCount;

  bool get hasCustomQuery => _filteredData.hasCustomQuery;

  List<Map<String, dynamic>> get data => _data;

  bool get hasData => _data.isNotEmpty;

  bool get hasColumns => hasData && _data[0].keys.isNotEmpty;

  String get title => '${_table.entityName} ($totalResults-${_data.length})';

  String get tableName => _table.entityName;

  Future<void> init(MoorTableViewerNavigator navigator, GeneratedDatabase db,
      TableInfo<moor.Table, DataClass> table) async {
    _navigator = navigator;
    _db = db;
    _table = table;
    _filteredData = cachingRepo.getFilterDataForTable(table);
    _getData();
  }

  Future<void> _getData() async {
    try {
      error = null;
      notifyListeners();
      // todo find a better way to acces the database for no this is fine
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      final countStream = _db.customSelect(
          'SELECT COUNT(*) FROM ${_table.actualTableName}',
          readsFrom: {_table}).watch();
      _subscriptionCount?.cancel();
      _subscriptionCount = countStream.listen((data) {
        totalResults = data.first.data['COUNT(*)'];
        notifyListeners();
      });

      final sqlQuery = _filteredData.selectQuery;
      final stream =
          // todo find a better way to acces the database for no this is fine
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          _db.customSelect(sqlQuery, readsFrom: {_table}).watch();
      _subscriptionList?.cancel();
      _subscriptionList = stream.listen((data) {
        final newData = data.map((item) => item.data).toList();

        final dateTimeType = DateTimeType();
        final boolType = BoolType();

        final correctData = List<Map<String, dynamic>>();
        newData.forEach((item) {
          final map = Map<String, dynamic>();
          item.keys.forEach((key) {
            final columns =
                _table.$columns.where((column) => column.$name == key);
            final column = columns.isEmpty ? null : columns.first;
            if (column is GeneratedDateTimeColumn) {
              final value = item[key];
              final dateTime = dateTimeType.mapFromDatabaseResponse(value);
              map[key] = dateTime?.toIso8601String();
            } else if (column is GeneratedBoolColumn) {
              final value = item[key];
              map[key] = boolType.mapFromDatabaseResponse(value).toString();
            } else {
              map[key] = item[key];
            }
          });
          correctData.add(map);
        });
        _data
          ..clear()
          ..addAll(correctData);
        notifyListeners();
      });
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  void onFilterClicked() {
    final newFilterData = _filteredData.copy();
    _navigator.goToFilter(_table, newFilterData);
  }

  void updateFilter(FilterData filterData) {
    _data.clear();
    _filteredData = filterData;
    cachingRepo.updateFilterData(_table.entityName, filterData);
    notifyListeners();
    _getData();
  }

  void onLongPressValue(item) {
    final clipboardData = ClipboardData(text: item.toString());
    Clipboard.setData(clipboardData);
    _navigator.showToast('Copied `${item.toString()}` to your clipboard');
  }

  void onItemClicked(Map<String, dynamic> data) {
    _navigator.goToItemDetail(_table, data);
  }

  @override
  void dispose() {
    _subscriptionCount?.cancel();
    _subscriptionCount = null;
    _subscriptionList?.cancel();
    _subscriptionList = null;
    super.dispose();
  }
}

abstract class MoorTableViewerNavigator {
  void goToFilter(
      TableInfo<moor.Table, DataClass> table, FilterData _filteredData);

  void goToItemDetail(
      TableInfo<moor.Table, DataClass> table, Map<String, dynamic> data);

  void showToast(String message);
}
