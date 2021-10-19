import 'package:moor_db_viewer/src/model/db/moor_db_viewer_database.dart';
import 'package:db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/repo/caching/caching_repo.dart';

class CachingRepository extends CachingRepo {
  MoorDbViewerDatabase db;
  final _filterData = Map<String, FilterData>();

  CachingRepository._(this.db);

  static init(MoorDbViewerDatabase db) => CachingRepo.initCacheRepo(CachingRepository._(db));

  FilterData getFilterDataForTable(String entityName) {
    if (!_filterData.containsKey(entityName)) {
      _filterData[entityName] = db.getFilterData(entityName);
    }
    return _filterData[entityName]!;
  }

  void updateFilterData(String entityName, FilterData filterData) {
    _filterData[entityName] = filterData;
  }
}
