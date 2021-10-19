import 'package:db_viewer/src/model/filter/filter_data.dart';

abstract class DbViewerDatabase {
  List<String> get tableNames;

  Future<List<Map<String, dynamic>>> customSelect(String query, {Set<String>? fromTableNames});

  Stream<List<Map<String, dynamic>>> customSelectStream(String query, {Set<String>? fromTableNames});

  Future<void> runCustomStatement(String query);

  Stream<int> count(String tableName);

  List<Map<String, dynamic>> remapData(String tableName, List<Map<String, dynamic>> data);

  FilterData getFilterData(String tableName);
}
