import 'package:db_viewer/src/model/filter/filter_data.dart';
import 'package:db_viewer/src/model/filter/where/where_clause.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

abstract interface class DbViewerDatabase {
  //EntityInfo
  List<String> get entityNames;

  List<String> getColumnNamesByEntityName(String entityName);

  List<Map<String, dynamic>> remapData(
      String entityName, List<Map<String, dynamic>> data);

  String getType(String entityName, String columnName);

  //Queries
  Future<List<Map<String, dynamic>>> customSelect(String query,
      {Set<String>? fromEntityNames});

  Stream<List<Map<String, dynamic>>> customSelectStream(String query,
      {Set<String>? fromEntityNames});

  Future<void> runCustomStatement(String query);

  Stream<int> count(String entityName);

  //Filter
  FilterData getFilterData(String entityName);

  FilterData getCachedFilterData(String entityName);

  void updateFilterData(String entityName, FilterData filterData);

  //UI
  Widget buildWhereWidget({
    required VoidCallback onAddClicked,
    required List<WhereClause> whereClauses,
  });

  static DbViewerDatabase of(BuildContext context) => Provider.of(context);
}
