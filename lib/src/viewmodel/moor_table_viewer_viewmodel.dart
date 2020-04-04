import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class MoorTableViewerViewModel with ChangeNotifier {
  GeneratedDatabase _db;
  MoorTableViewerNavigator _navigator;
  TableInfo<moor.Table, DataClass> _table;

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
      // todo find a better way to acces the database for no this is fine

      final sqlQuery =
          'SELECT * FROM ${_table.actualTableName} ${_filteredData.getWhere()} ${_filteredData.getLimit()}';
//      print(sqlQuery);
      final result =
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
    notifyListeners();
    _getData();
  }
}

abstract class MoorTableViewerNavigator {
  void goToFilter(
      TableInfo<moor.Table, DataClass> table, FilterData _filteredData);
}
