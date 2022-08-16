import 'package:drift/drift.dart';
import 'package:drift/drift.dart' as drift;
import 'package:drift_db_viewer/src/model/filter/where/blob_where_clause.dart';
import 'package:drift_db_viewer/src/model/filter/where/bool_where_clause.dart';
import 'package:drift_db_viewer/src/model/filter/where/date_where_clause.dart';
import 'package:drift_db_viewer/src/model/filter/where/double_where_clause.dart';
import 'package:drift_db_viewer/src/model/filter/where/int_where_clause.dart';
import 'package:drift_db_viewer/src/model/filter/where/string_where_clause.dart';
import 'package:db_viewer/db_viewer.dart';

class DriftFilterData extends FilterData {
  final TableInfo<drift.Table, dynamic> _table;
  final SqlTypes _types;

  DriftFilterData(this._table, this._types) : super();

  @override
  Map<String, bool> getSelectedColumns() {
    final selectColumns = <String, bool>{};
    _table.columnsByName.keys.forEach((item) {
      selectColumns[item] = false;
    });
    return selectColumns;
  }

  @override
  String get tableName => _table.actualTableName;

  @override
  WhereClause? getWhereClause(String columnName) {
    if (!_table.columnsByName.containsKey(columnName)) return null;
    final detail =
        _table.$columns.where((item) => item.$name == columnName).first;
    if (detail is GeneratedColumn<String>) {
      return StringWhereClause(columnName);
    } else if (detail is GeneratedColumn<int>) {
      return IntWhereClause(columnName);
    } else if (detail is GeneratedColumn<DateTime>) {
      return DateWhereClause(columnName, _types);
    } else if (detail is GeneratedColumn<bool>) {
      return BoolWhereClause(columnName, _types);
    } else if (detail is GeneratedColumn<double>) {
      return DoubleWhereClause(columnName);
    } else if (detail is GeneratedColumn<Uint8List>) {
      return BlobWhereClause(columnName);
    } else {
      print('$detail is not yet supported');
      return null;
    }
  }

  @override
  FilterData copy() => copyTo(DriftFilterData(_table, _types));
}
