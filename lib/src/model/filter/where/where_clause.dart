abstract class WhereClause {
  final _createDate = DateTime.now();
  String columnName;

  String get typeName;

  String get id => _createDate.millisecondsSinceEpoch.toString();

  WhereClause({required this.columnName});

  String getSqlWhereClause();

  WhereClause copy();
}
