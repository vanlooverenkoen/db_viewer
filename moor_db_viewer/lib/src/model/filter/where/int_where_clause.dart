import 'package:flutter/material.dart';
import 'package:db_viewer/src/model/filter/where/where_clause.dart';

class IntWhereClause extends WhereClause {
  IntWhereType _intWhereType = IntWhereType.EQUALS;
  String _query = '';

  IntWhereType get intWhereType => _intWhereType;

  @override
  String get typeName => 'INTEGER';

  TextEditingController textController = TextEditingController();

  IntWhereClause(String columnName) : super(columnName: columnName);

  void updateQuery(String value) => _query = value;

  void onSelectedType(IntWhereType value) => _intWhereType = value;

  @override
  String getSqlWhereClause() {
    if (_query.isEmpty) return '';
    if (_intWhereType == IntWhereType.CONTAINS)
      return ' $columnName LIKE \'%$_query%\'';
    if (_intWhereType == IntWhereType.EQUALS) return ' $columnName = $_query';
    if (_intWhereType == IntWhereType.GREATER_THAN)
      return ' $columnName > $_query';
    if (_intWhereType == IntWhereType.LESS_THAN)
      return ' $columnName < $_query';
    return '';
  }

  @override
  WhereClause copy() {
    final whereClause = IntWhereClause(columnName);
    whereClause._query = _query;
    whereClause._intWhereType = _intWhereType;
    whereClause.textController = TextEditingController(text: _query);
    return whereClause;
  }
}

enum IntWhereType {
  CONTAINS,
  EQUALS,
  GREATER_THAN,
  LESS_THAN,
}
