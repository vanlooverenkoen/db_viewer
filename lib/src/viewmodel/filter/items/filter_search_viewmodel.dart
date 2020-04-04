import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_search_item.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class FilterSearchViewModel with ChangeNotifier {
  // ignore: unused_field
  GeneratedDatabase _db;
  TableInfo<moor.Table, DataClass> _table;
  FilterSearchItem _filterItem;

  final data = List<Map<String, dynamic>>();

  TextEditingController controller;

  bool get hasData => data.isNotEmpty;

  String get title => '${_table.entityName} Filter';

  String get tableName => _table.entityName;

  List<GeneratedColumn> get columns => _table.$columns;

  FilterSearchViewModel(this._db, this._table, this._filterItem) {
    controller = TextEditingController();
    controller.text = _filterItem.searchQuery;
    notifyListeners();
    _getData();
  }

  Future<void> _getData() async {}

  void onSearchQueryChanged(String value) {
    _filterItem.onUpdateSearchQuery(value);
  }

  void onColumnConfirmed(GeneratedColumn column, bool value) {
    if (!value) return;
    _filterItem.onUpdateColumn(column.$name);
    notifyListeners();
  }

  bool isColumnSelected(GeneratedColumn column) =>
      _filterItem.column == column.$name;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
