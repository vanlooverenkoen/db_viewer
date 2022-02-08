import 'package:db_viewer/src/model/db/db.dart';
import 'package:flutter/material.dart';
import 'package:db_viewer/src/model/filter/filter_data.dart';
import 'package:db_viewer/src/model/filter/where/where_clause.dart';

class TableFilterViewModel with ChangeNotifier {
  final TableFilterNavigator _navigator;
  late FilterData _filterData;
  String _tableName;

  String get title => '$tableName Filter';

  String get selectQuery => _filterData.selectQuery;

  bool get isEditedQuery => _filterData.isEditedQuery;

  String get tableName => _tableName;

  bool get areAllColumnsSelected => _filterData.areAllColumnsSelected;

  Map<String, bool> get selectColumns => _filterData.selectColumns;

  Map<String, bool> get orderByColumns => _filterData.orderByColumns;

  List<WhereClause> get whereClauses => _filterData.whereClauses;

  bool get asc => _filterData.asc;

  int get limit => _filterData.limit;

  DbViewerDatabase get _db => DbViewerDatabase.instance();

  TableFilterViewModel(
    this._navigator,
    this._tableName,
    FilterData? filterData,
  ) {
    if (filterData == null) {
      _filterData = _db.getCachedFilterData(_tableName);
    } else {
      _filterData = filterData;
    }
    notifyListeners();
  }

  void onSelectAllColumns() {
    _filterData.selectAllColumns();
    notifyListeners();
  }

  void onToggleColumn(String value) {
    _filterData.onToggleColumn(value);
    notifyListeners();
  }

  void onBackClicked() => _navigator.goBack(null);

  void onSaveClicked() => _navigator.goBack(_filterData);

  void onAscClicked() {
    _filterData.onAscClicked();
    notifyListeners();
  }

  void onDescClicked() {
    _filterData.onDescClicked();
    notifyListeners();
  }

  void onToggleOrderByColumn(String value) {
    _filterData.onToggleOrderByColumn(value);
    notifyListeners();
  }

  void onAddClicked() {
    _navigator.showAddWhereClause(_tableName);
  }

  void onWhereColumnSelected(String result) {
    _filterData.onWhereColumnSelected(result);
    notifyListeners();
  }

  void onUpdatedWhereClause() {
    _filterData.onUpdatedWhereClause();
    notifyListeners();
  }

  void onDismissWhereClause(WhereClause whereClause) {
    _filterData.remove(whereClause);
    notifyListeners();
  }

  void onEditClicked() => _navigator.showEdit(selectQuery);

  void onUpdateCustomSqlQuery(String query) {
    _filterData.updateCustomSqlQuery(query);
    notifyListeners();
  }

  void oClearCustomSqlQueryClicked() {
    _filterData.clearCustomSqlQuery();
    notifyListeners();
  }
}

abstract class TableFilterNavigator {
  void goBack(FilterData? filterData);

  void showAddWhereClause(String entityName);

  void showEdit(String selectQuery);
}
