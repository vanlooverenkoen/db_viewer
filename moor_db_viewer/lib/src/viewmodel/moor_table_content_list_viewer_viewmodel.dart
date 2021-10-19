import 'dart:async';

import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/repo/caching/caching_repo.dart';

class MoorTableContentListViewerViewModel with ChangeNotifier {
  late DbViewerDatabase _db;
  late MoorTableViewerNavigator _navigator;
  late String _tableName;
  final cachingRepo = CachingRepo.instance();

  final _data = <Map<String, dynamic>>[];

  late FilterData _filteredData;

  int totalResults = 0;

  String? error;

  StreamSubscription<List<Map<String, dynamic>>>? _subscriptionList;
  StreamSubscription<int>? _subscriptionCount;

  bool get hasCustomQuery => _filteredData.hasCustomQuery;

  List<Map<String, dynamic>> get data => _data;

  bool get hasData => _data.isNotEmpty;

  bool get hasColumns => hasData && _data[0].keys.isNotEmpty;

  String get title => '$_tableName ($totalResults-${_data.length})';

  String get tableName => _tableName;

  Future<void> init(MoorTableViewerNavigator navigator, DbViewerDatabase db, String tableName) async {
    _navigator = navigator;
    _db = db;
    _tableName = tableName;
    _filteredData = cachingRepo.getFilterDataForTable(tableName);
    _getData();
  }

  Future<void> _getData() async {
    try {
      error = null;
      notifyListeners();
      // todo find a better way to acces the database for no this is fine
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      final countStream = _db.count(_tableName);
      _subscriptionCount?.cancel();
      _subscriptionCount = countStream.listen((data) {
        totalResults = data;
        notifyListeners();
      });

      final sqlQuery = _filteredData.selectQuery;
      final stream =
          // todo find a better way to acces the database for no this is fine
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          _db.customSelectStream(sqlQuery, fromTableNames: {_tableName});
      _subscriptionList?.cancel();
      _subscriptionList = stream.listen((data) {
        final correctData = _db.remapData(tableName, data);
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
    _navigator.goToFilter(_tableName, newFilterData);
  }

  void updateFilter(FilterData filterData) {
    _data.clear();
    _filteredData = filterData;
    cachingRepo.updateFilterData(_tableName, filterData);
    notifyListeners();
    _getData();
  }

  void onLongPressValue(item) {
    final clipboardData = ClipboardData(text: item.toString());
    Clipboard.setData(clipboardData);
    _navigator.showToast('Copied `${item.toString()}` to your clipboard');
  }

  void onItemClicked(Map<String, dynamic> data) {
    _navigator.goToItemDetail(_tableName, data);
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
  void goToFilter(String table, FilterData _filteredData);

  void goToItemDetail(String table, Map<String, dynamic> data);

  void showToast(String message);
}
