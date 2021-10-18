import 'package:moor_db_viewer/src/model/db/moor_db_viewer_database.dart';
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/repo/caching/caching_repo.dart';

class CachingRepository extends CachingRepo {
  MoorDbViewerDatabase db;
  final _filterData = Map<String, FilterData>();

  CachingRepository._(this.db);

  static init(MoorDbViewerDatabase db) => CachingRepo.initCacheRepo(CachingRepository._(db));

  FilterData getFilterDataForTable(String entityName) {
    final tables = db.tables.where((element) => element.actualTableName == entityName).toList();
    if (tables.isEmpty) throw ArgumentError('$entityName is not found in table');
    if (!_filterData.containsKey(entityName)) {
      _filterData[entityName] = FilterData(tables.first);
    }
    return _filterData[entityName]!;
  }

  void updateFilterData(String entityName, FilterData filterData) {
    _filterData[entityName] = filterData;
  }
}
