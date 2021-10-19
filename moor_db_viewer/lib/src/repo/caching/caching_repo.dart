import 'package:db_viewer/src/model/filter/filter_data.dart';

abstract class CachingRepo {
  static CachingRepo? _instance;

  static CachingRepo instance() => _instance!;

  static void initCacheRepo(CachingRepo cachingRepo) => _instance = cachingRepo;

  FilterData getFilterDataForTable(String tableName);

  void updateFilterData(String entityName, FilterData filterData);
}
