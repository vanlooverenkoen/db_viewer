import 'package:flutter/cupertino.dart';
import 'package:db_viewer/src/model/filter/where/where_clause.dart';

class StringWhereClause extends WhereClause {
  StringWhereType _stringWhereType = StringWhereType.CONTAINS;
  String _query = '';
  TextEditingController textController = TextEditingController();

  StringWhereType get stringWhereType => _stringWhereType;

  @override
  String get typeName => 'TEXT';

  StringWhereClause(String columnName) : super(columnName: columnName);

  void updateQuery(String value) => _query = value;

  void onSelectedType(StringWhereType value) => _stringWhereType = value;

  @override
  String getSqlWhereClause() {
    if (_query.isEmpty) return '';
    if (_stringWhereType == StringWhereType.CONTAINS)
      return ' $columnName LIKE \'%$_query%\'';
    if (_stringWhereType == StringWhereType.EQUALS)
      return ' $columnName = \'$_query\'';
    if (_stringWhereType == StringWhereType.NOT_CONTAINS)
      return ' NOT $columnName LIKE \'%$_query%\'';
    if (_stringWhereType == StringWhereType.NOT_EQUALS)
      return ' NOT $columnName = \'$_query\'';
    return '';
  }

  @override
  WhereClause copy() {
    final whereClause = StringWhereClause(columnName);
    whereClause._stringWhereType = _stringWhereType;
    whereClause._query = _query;
    whereClause.textController = TextEditingController(text: _query);
    return whereClause;
  }
}

enum StringWhereType {
  CONTAINS,
  EQUALS,
  NOT_CONTAINS,
  NOT_EQUALS,
}
