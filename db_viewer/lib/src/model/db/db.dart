import 'package:db_viewer/src/model/filter/filter_data.dart';

abstract class DbViewerDatabase {
  static DbViewerDatabase? _instance;

  static DbViewerDatabase instance() => _instance!;

  static void initDb(DbViewerDatabase db) => _instance = db;

  List<String> get tableNames;

  Future<List<Map<String, dynamic>>> customSelect(String query, {Set<String>? fromTableNames});

  Stream<List<Map<String, dynamic>>> customSelectStream(String query, {Set<String>? fromTableNames});

  Future<void> runCustomStatement(String query);

  Stream<int> count(String tableName);

  List<Map<String, dynamic>> remapData(String tableName, List<Map<String, dynamic>> data);

  FilterData getFilterData(String tableName);

  FilterData getCachedFilterData(String entityName);

  void updateFilterData(String entityName, FilterData filterData);
}
