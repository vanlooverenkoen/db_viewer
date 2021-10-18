import 'package:db_viewer/db_viewer.dart';
import 'package:moor/moor.dart';

class MoorDbViewerDatabase implements DbViewerDatabase {
  final GeneratedDatabase db;

  MoorDbViewerDatabase(this.db);

  @override
  Future<List<Map<String, dynamic>>> customSelect(String query, {Set<String>? fromTableNames}) async {
    final result = await db.customSelect(query).get();
    return result.map((e) => e.data).toList();
  }

  @override
  Stream<List<Map<String, dynamic>>> customSelectStream(String query, {Set<String>? fromTableNames}) => db.customSelect(query).map((item) => item.data).watch();

  @override
  Future<void> runCustomStatement(String query) async => await db.customStatement(query);

  @override
  List<String> get tableNames => db.allTables.map((e) => e.entityName).toList();

  Iterable<TableInfo<Table, dynamic>> get tables => db.allTables;

  TableInfo<Table, dynamic>? getTable(String tableName) {
    final tables = db.allTables.where((element) => element.actualTableName == tableName);
    if (tables.isEmpty) return null;
    return tables.first;
  }

  @override
  Stream<int> count(String tableName) {
    final table = getTable(tableName);
    if (table == null) return Stream.value(0);
    final countStream = db.customSelect('SELECT COUNT(*) FROM ${tableName}', readsFrom: {table}).watch();
    return countStream.map((data) => data.first.data['COUNT(*)']);
  }

  @override
  List<Map<String, dynamic>> remapData(String tableName, List<Map<String, dynamic>> data) {
    final dateTimeType = DateTimeType();
    final boolType = BoolType();
    final table = getTable(tableName);
    if (table == null) return data;
    final correctData = <Map<String, dynamic>>[];
    data.forEach((item) {
      final map = <String, dynamic>{};
      item.keys.forEach((key) {
        final columns = table.$columns.where((column) => column.$name == key);
        final column = columns.isEmpty ? null : columns.first;
        if (column is GeneratedColumn<DateTime> || column is GeneratedColumn<DateTime?>) {
          final value = item[key];
          final dateTime = dateTimeType.mapFromDatabaseResponse(value);
          map[key] = dateTime?.toIso8601String();
        } else if (column is GeneratedColumn<bool> || column is GeneratedColumn<bool?>) {
          final value = item[key];
          map[key] = boolType.mapFromDatabaseResponse(value).toString();
        } else {
          map[key] = item[key];
        }
      });
      correctData.add(map);
    });
    return correctData;
  }
}
