import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/model/filter/filter_limit_results_item.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class MoorTableViewerViewModel with ChangeNotifier {
  GeneratedDatabase _db;
  MoorTableViewerNavigator _navigator;
  TableInfo<moor.Table, DataClass> _table;

  final _data = List<Map<String, dynamic>>();
  final _filteredDataList = List<Map<String, dynamic>>();
  var _filteredData = FilterData();

  int totalResults = 0;

  List<Map<String, dynamic>> get filteredData => _filteredDataList;

  bool get hasData => _filteredDataList.isNotEmpty;

  bool get hasColumns => hasData && _filteredDataList[0].keys.isNotEmpty;

  String get title =>
      '${_table.entityName} ($totalResults-${_filteredDataList.length})';

  String get tableName => _table.entityName;

  Future<void> init(MoorTableViewerNavigator navigator, GeneratedDatabase db,
      TableInfo<moor.Table, DataClass> table) async {
    _navigator = navigator;
    _db = db;
    _table = table;
    _getData();
  }

  Future<void> _getData() async {
    // todo find a better way to acces the database for no this is fine
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    final result1 = await _db.customSelectQuery(
        'SELECT COUNT(*) FROM ${_table.actualTableName}',
        readsFrom: {_table}).get();
    totalResults = result1.first.data['COUNT(*)'];
    // todo find a better way to acces the database for no this is fine
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    final query = _db.select(_table);
    final limitFilter = _filteredData.filters[0];
    if (limitFilter is FilterLimitResultsItem) {
      query.limit(limitFilter.limit);
    }
    final result = await query.get();
    final _newData = result.map((item) => item.toJson()).toList();
    _data
      ..clear()
      ..addAll(_newData);
    final newFilterData = _filteredData?.applyFilter(_newData) ?? _newData;
    _filteredDataList
      ..clear()
      ..addAll(newFilterData);
    notifyListeners();
  }

  void onFilterClicked() => _navigator.goToFilter(_table, _filteredData);

  void updateFilter(FilterData filterData) {
    _data.clear();
    _filteredDataList.clear();
    _filteredData = filterData;
    notifyListeners();
    _getData();
  }
}

abstract class MoorTableViewerNavigator {
  void goToFilter(
      TableInfo<moor.Table, DataClass> table, FilterData _filteredData);
}
