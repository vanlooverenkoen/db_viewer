import 'package:flutter/material.dart';
import 'package:db_viewer/src/model/filter/where/where_clause.dart';

class DoubleWhereClause extends WhereClause {
  DoubleWhereType _intWhereType = DoubleWhereType.EQUALS;
  String _query = '';

  DoubleWhereType get intWhereType => _intWhereType;

  @override
  String get typeName => 'INTEGER';

  TextEditingController textController = TextEditingController();

  DoubleWhereClause(String columnName) : super(columnName: columnName);

  void updateQuery(String value) => _query = value;

  void onSelectedType(DoubleWhereType value) => _intWhereType = value;

  @override
  String getSqlWhereClause() {
    if (_query.isEmpty) return '';
    if (_intWhereType == DoubleWhereType.CONTAINS)
      return ' $columnName LIKE \'%$_query%\'';
    if (_intWhereType == DoubleWhereType.EQUALS)
      return ' $columnName = $_query';
    if (_intWhereType == DoubleWhereType.GREATER_THAN)
      return ' $columnName > $_query';
    if (_intWhereType == DoubleWhereType.LESS_THAN)
      return ' $columnName < $_query';
    return '';
  }

  @override
  WhereClause copy() {
    final whereClause = DoubleWhereClause(columnName);
    whereClause._query = _query;
    whereClause._intWhereType = _intWhereType;
    whereClause.textController = TextEditingController(text: _query);
    return whereClause;
  }
}

enum DoubleWhereType {
  CONTAINS,
  EQUALS,
  GREATER_THAN,
  LESS_THAN,
}
