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
  var _filteredData = FilterData();

  int totalResults = 0;

  String error;

  bool get hasFilter => _filteredData.hasFilters;

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
    _filteredData = cachingRepo.getFilterDataForTable(_table.entityName);
    _getData();
  }

  Future<void> _getData() async {
    try {
      error = null;
      notifyListeners();
      // todo find a better way to acces the database for no this is fine
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      final result1 = await _db.customSelectQuery(
          'SELECT COUNT(*) FROM ${_table.actualTableName}',
          readsFrom: {_table}).get();
      totalResults = result1.first.data['COUNT(*)'];

      final sqlQuery =
          'SELECT * FROM ${_table.actualTableName} ${_filteredData.getWhere()} ${_filteredData.getLimit()}';
//      print(sqlQuery);

      final result =
          // todo find a better way to acces the database for no this is fine
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          await _db.customSelectQuery(sqlQuery, readsFrom: {_table}).get();
      final _newData = result.map((item) => item.data).toList();
      final _correctDisplayData = _filteredData.removeColumns(_newData);
      _data
        ..clear()
        ..addAll(_correctDisplayData);
    } catch (e) {
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void onRefreshClicked() => _getData();

  void onFilterClicked() => _navigator.goToFilter(_table, _filteredData);

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
}

abstract class MoorTableViewerNavigator {
  void goToFilter(
      TableInfo<moor.Table, DataClass> table, FilterData _filteredData);

  void goToItemDetail(
      TableInfo<moor.Table, DataClass> table, Map<String, dynamic> data);

  void showToast(String message);
}
