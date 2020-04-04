import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_column_item.dart';
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/model/filter/filter_item.dart';
import 'package:moor_db_viewer/src/model/filter/filter_limit_results_item.dart';
import 'package:moor_db_viewer/src/model/filter/filter_search_item.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class MoorTableFilterViewModel with ChangeNotifier {
  // ignore: unused_field
  final GeneratedDatabase _db;
  final MoorTableFilterNavigator _navigator;
  final TableInfo<moor.Table, DataClass> _table;

  final data = List<Map<String, dynamic>>();

  bool get hasData => data.isNotEmpty;

  String get title => '${_table.entityName} Filter';

  String get tableName => _table.entityName;

  var filterData = FilterData();

  List<GeneratedColumn> get columns => _table.$columns;

  TableInfo<moor.Table, DataClass> get table => _table;

  MoorTableFilterViewModel(
    this._navigator,
    this._db,
    this._table,
    FilterData filterData,
  ) {
    if (filterData == null) {
      this.filterData = filterData;
    }
    this.filterData = filterData;
    _getData();
  }

  Future<void> _getData() async {}

  void onBackClicked() {
    _navigator.goBack(filterData);
  }

  void onAddFilterClicked() {
    filterData.addFilter(FilterSearchItem());
    notifyListeners();
  }

  void onRemove(FilterItem filterItem) {
    filterData.remove(filterItem);
    notifyListeners();
  }

  void onEnableFilterChanged(FilterItem filterItem, bool value) {
    filterItem.setEnabled(value);
    notifyListeners();
  }

  void changePositionOfFilters(int oldIndex, int newIndex) {
    final oldItem = filterData.filters[oldIndex];
    final newItem = filterData.filters[newIndex];
    if (oldItem is FilterLimitResultsItem ||
        newItem is FilterLimitResultsItem) {
      //does nothing;
    } else if (oldItem is FilterColumnsItem || newItem is FilterColumnsItem) {
      //does nothing;
    } else {
      filterData.filters.removeAt(oldIndex);
      filterData.filters.insert(newIndex, oldItem);
    }
    notifyListeners();
  }
}

abstract class MoorTableFilterNavigator {
  void goBack(FilterData filterData);

  void goToFilterSelector();
}
