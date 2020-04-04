import 'package:moor_db_viewer/src/model/filter/filter_column_item.dart';
import 'package:moor_db_viewer/src/model/filter/filter_item.dart';
import 'package:moor_db_viewer/src/model/filter/filter_limit_results_item.dart';
import 'package:moor_db_viewer/src/model/filter/filter_search_item.dart';

class FilterData {
  final filters = List<FilterItem>();

  bool get hasFilters => filters.length > 2;

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

  bool containsFilters() => filters.where((filter) => filter.isEnabled).isNotEmpty;

  List<Map<String, dynamic>> removeColumns(List<Map<String, dynamic>> newData) {
    var data = newData;
    for (final filter in filters) {
      if (filter.isEnabled && filter is FilterColumnsItem) {
        data = filter.removeColumns(data);
      }
    }
    return data;
  }

  String getWhere() {
    var where = '';
    final searchItems = filters.where((filter) => filter.isEnabled && filter is FilterSearchItem && filter.hasFilter).map((filter) => filter as FilterSearchItem).toList();
    for (var i = 0; i < searchItems.length; ++i) {
      final filter = searchItems[i];
      where += filter.getWhereClause();
      if (i != searchItems.length - 1) where += ' AND ';
    }
    if(where.isNotEmpty){
      where = 'WHERE $where';
    }
    return where;
  }

  String getLimit() {
    final filterItem = filters.firstWhere((filter) => filter.isEnabled && filter is FilterLimitResultsItem);
    if (filterItem is FilterLimitResultsItem) {
      return 'LIMIT ${filterItem.limit}';
    }
    return '';
  }
}
