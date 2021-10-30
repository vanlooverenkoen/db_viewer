import 'package:db_viewer/src/model/filter/where/where_clause.dart';
import 'package:flutter/widgets.dart';

abstract class FilterData {
  int _limit = 20;
  bool _asc = true;
  String? _orderingColumn;
  String? _selectQuery;
  @protected
  late Map<String, bool> _selectColumns;
  List<WhereClause> _whereClauses = <WhereClause>[];

  String? _customSqlQuery;

  int get limit => _limit;

  bool get asc => _asc;

  bool get hasCustomQuery =>
      _selectQuery != 'SELECT * FROM $tableName LIMIT 20';

  bool get isEditedQuery => _customSqlQuery != null;

  String get tableName;

  Map<String, bool> get selectColumns => _selectColumns;

  List<WhereClause> get whereClauses => _whereClauses;

  Map<String, bool> get orderByColumns {
    final map = <String, bool>{};
    _selectColumns.forEach((key, value) {
      if (key == _orderingColumn) {
        map[key] = true;
      } else {
        map[key] = false;
      }
    });
    return map;
  }

  bool get areAllColumnsSelected => !_selectColumns.values.contains(true);

  String get selectQuery {
    if (_selectQuery == null) {
      createQuery();
    }
    return _selectQuery!;
  }

  FilterData() {
    selectAllColumns();
    createQuery();
  }

  void createQuery() {
    if (isEditedQuery) {
      _selectQuery = _customSqlQuery;
      return;
    }
    final sb = StringBuffer('SELECT');
    if (areAllColumnsSelected) {
      sb.write(' *');
    } else {
      final list = <String>[];
      for (var i = 0; i < _selectColumns.keys.length; ++i) {
        if (_selectColumns.values.toList()[i]) {
          list.add(_selectColumns.keys.toList()[i]);
        }
      }
      for (var i = 0; i < list.length; ++i) {
        sb.write(' ${list[i]}');
        if (i < list.length - 1) {
          sb.write(',');
        }
      }
    }

    sb.write(' FROM $tableName');

    final sqlWhereClauses = whereClauses
        .map((item) => item.getSqlWhereClause())
        .where((item) => item.isNotEmpty)
        .toList();

    if (sqlWhereClauses.isNotEmpty) {
      sb.write(' WHERE');

      for (var i = 0; i < sqlWhereClauses.length; ++i) {
        final clause = sqlWhereClauses[i];
        sb.write(clause);
        if (i != sqlWhereClauses.length - 1) {
          sb.write(' AND');
        }
      }
    }

    if (_orderingColumn != null && _orderingColumn!.isNotEmpty) {
      sb.write(' ORDER BY $_orderingColumn');
      if (_asc) {
        sb.write(' ASC');
      } else {
        sb.write(' DESC');
      }
    }
    sb.write(' LIMIT $_limit');
    _selectQuery = sb.toString();
  }

  Map<String, bool> getSelectedColumns();

  void selectAllColumns() {
    _selectColumns = getSelectedColumns();
    createQuery();
  }

  void onToggleColumn(String value) {
    final oldValue = _selectColumns[value];
    if (oldValue != null) {
      _selectColumns[value] = !oldValue;
      if (!_selectColumns.values.contains(false)) {
        selectAllColumns();
      }
      createQuery();
    }
  }

  void onAscClicked() {
    _asc = true;
    createQuery();
  }

  void onDescClicked() {
    _asc = false;
    createQuery();
  }

  void onToggleOrderByColumn(String value) {
    if (_orderingColumn == value) {
      _orderingColumn = null;
    } else {
      _orderingColumn = value;
    }
    createQuery();
  }

  WhereClause? getWhereClause(String columnName);

  void onWhereColumnSelected(String columnName) {
    final whereClause = getWhereClause(columnName);
    if (whereClause == null) return;
    _whereClauses.add(whereClause);
    createQuery();
  }

  void onUpdatedWhereClause() {
    createQuery();
  }

  void remove(WhereClause whereClause) {
    _whereClauses.remove(whereClause);
    createQuery();
  }

  void updateCustomSqlQuery(String query) {
    _customSqlQuery = query;
    createQuery();
  }

  void clearCustomSqlQuery() {
    _customSqlQuery = null;
    createQuery();
  }

  FilterData copy();

  @protected
  FilterData copyTo(FilterData newFilterData) {
    newFilterData._selectQuery = _selectQuery;
    newFilterData._limit = _limit;
    final map = <String, bool>{};
    _selectColumns.forEach((key, value) => map[key] = value);
    newFilterData._selectColumns = map;
    newFilterData._customSqlQuery = _customSqlQuery;
    newFilterData._asc = _asc;
    newFilterData._orderingColumn = _orderingColumn;
    final whereClauses = _whereClauses.map((clause) => clause.copy()).toList();
    newFilterData._whereClauses = whereClauses;
    return newFilterData;
  }
}
