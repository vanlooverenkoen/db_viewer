import 'package:moor_db_viewer/src/model/filter/filter_column_item.dart';
import 'package:moor_db_viewer/src/model/filter/filter_item.dart';
import 'package:moor_db_viewer/src/model/filter/filter_limit_results_item.dart';

class FilterData {
  final filters = List<FilterItem>();

  FilterData() {
    filters.add(FilterLimitResultsItem());
    filters.add(FilterColumnsItem());
  }

  void addFilter(FilterItem filterItem) {
    filters.add(filterItem);
  }

  void remove(FilterItem filterItem) {
    filters.remove(filterItem);
  }

  bool containsFilters() =>
      filters.where((filter) => filter.isEnabled).isNotEmpty;

  List<Map<String, dynamic>> applyFilter(List<Map<String, dynamic>> newData) {
    var data = newData;
    for (final filter in filters) {
      if (filter.isEnabled) {
        data = filter.applyFilter(data);
      }
    }
    return data;
  }
}
