import 'package:db_viewer/src/model/filter/where/where_clause.dart';
import 'package:drift/drift.dart';

class BoolWhereClause extends WhereClause {
  bool _value = true;
  final SqlTypes _types;

  @override
  String get typeName => 'BOOL';

  bool get value => _value;

  BoolWhereClause(String columnName, this._types)
      : super(columnName: columnName);

  @override
  String getSqlWhereClause() {
    return ' $columnName = ${_types.mapToSqlVariable(_value)}';
  }

  @override
  WhereClause copy() {
    final whereClause = BoolWhereClause(columnName, _types);
    whereClause._value = _value;
    return whereClause;
  }

  void onSelectedChanged(bool value) => _value = value;
}
