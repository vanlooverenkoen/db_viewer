import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_column_item.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class FilterColumnsViewModel with ChangeNotifier {
  // ignore: unused_field
  final GeneratedDatabase _db;
  final TableInfo<moor.Table, DataClass> _table;

  final FilterColumnsItem _filterItem;

  FilterColumnsViewModel(this._db, this._table, this._filterItem);

  final data = List<Map<String, dynamic>>();

  bool get hasData => data.isNotEmpty;

  String get title => '${_table.entityName} Filter';

  String get tableName => _table.entityName;

  List<GeneratedColumn> get columns => _table.$columns;

  bool isColumnSelected(GeneratedColumn column) =>
      _filterItem.isColumnShown(column);

  void onColumnSelectionChanged(GeneratedColumn column, bool value) {
    _filterItem.setColumnShown(column, value);
    notifyListeners();
  }
}
