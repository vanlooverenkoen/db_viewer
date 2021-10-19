import 'package:db_viewer/src/model/filter/filter_data.dart';

abstract class DbViewerDatabase {
  static DbViewerDatabase? _instance;

  DbViewerDatabase._();

  static DbViewerDatabase instance() => _instance!;

  static void initDb(DbViewerDatabase db) => _instance = db;

  //EntityInfo
  List<String> get entityNames;

  List<String> getColumnNamesByEntityName(String entityName);

  List<Map<String, dynamic>> remapData(String entityName, List<Map<String, dynamic>> data);

  String getType(String entityName, String columnName);

  //Queries
  Future<List<Map<String, dynamic>>> customSelect(String query, {Set<String>? fromEntityNames});

  Stream<List<Map<String, dynamic>>> customSelectStream(String query, {Set<String>? fromEntityNames});

  Future<void> runCustomStatement(String query);

  Stream<int> count(String entityName);

  //Filter
  FilterData getFilterData(String entityName);

  FilterData getCachedFilterData(String entityName);

  void updateFilterData(String entityName, FilterData filterData);
}
