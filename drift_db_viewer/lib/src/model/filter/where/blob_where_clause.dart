import 'package:db_viewer/src/model/filter/where/where_clause.dart';

class BlobWhereClause extends WhereClause {
  @override
  String get typeName => 'BLOB';

  BlobWhereClause(String columnName) : super(columnName: columnName);

  @override
  String getSqlWhereClause() => '';

  @override
  WhereClause copy() {
    final whereClause = BlobWhereClause(columnName);
    return whereClause;
  }
}
