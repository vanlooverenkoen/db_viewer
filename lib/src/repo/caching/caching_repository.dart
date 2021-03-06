import 'package:moor/moor.dart';
import 'package:moor/moor.dart' as moor;
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/repo/caching/caching_repo.dart';

class CachingRepository extends CachingRepo {
  static CachingRepository? _instance;
  final _filterData = Map<String, FilterData>();

  CachingRepository._();

  factory CachingRepository.instance() => _instance ??= CachingRepository._();

  FilterData getFilterDataForTable(TableInfo<moor.Table, DataClass> table) {
    final entityName = table.entityName;
    if (!_filterData.containsKey(entityName)) {
      _filterData[entityName] = FilterData(table);
    }
    return _filterData[entityName]!;
  }

  void updateFilterData(String entityName, FilterData filterData) {
    _filterData[entityName] = filterData;
  }
}
