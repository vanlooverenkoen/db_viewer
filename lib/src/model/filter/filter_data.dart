import 'package:moor/moor.dart';
import 'package:moor/moor.dart' as moor;
import 'package:moor_db_viewer/src/model/filter/where/blob_where_clause.dart';
import 'package:moor_db_viewer/src/model/filter/where/bool_where_clause.dart';
import 'package:moor_db_viewer/src/model/filter/where/date_where_clause.dart';
import 'package:moor_db_viewer/src/model/filter/where/double_where_clause.dart';
import 'package:moor_db_viewer/src/model/filter/where/int_where_clause.dart';
import 'package:moor_db_viewer/src/model/filter/where/string_where_clause.dart';
import 'package:moor_db_viewer/src/model/filter/where/where_clause.dart';

class FilterData {
  final TableInfo<moor.Table, DataClass> _tableInfo;

  int _limit = 20;
  bool _asc = true;
  String? _orderingColumn;
  String? _selectQuery;
  late Map<String, bool> _selectColumns;
  List<WhereClause> _whereClauses = <WhereClause>[];

  String? _customSqlQuery;

  int get limit => _limit;

  bool get asc => _asc;

  bool get hasCustomQuery =>
      _selectQuery != 'SELECT * FROM $tableName LIMIT 20';

  bool get isEditedQuery => _customSqlQuery != null;

  String get tableName => _tableInfo.entityName;

  Map<String, bool> get selectColumns => _selectColumns;

  List<WhereClause> get whereClauses => _whereClauses;

  Map<String, bool> get orderByColumns {
    final map = Map<String, bool>();
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
      createSqlQuery();
    }
    return _selectQuery!;
  }

  FilterData(this._tableInfo) {
    selectAllColumns();
    createSqlQuery();
  }

  void createSqlQuery() {
    if (isEditedQuery) {
      _selectQuery = _customSqlQuery;
      return;
    }
    final sb = StringBuffer('SELECT');
    if (areAllColumnsSelected) {
      sb.write(' *');
    } else {
      final list = <String>[];
      for (var i = 0; i < selectColumns.keys.length; ++i) {
        if (selectColumns.values.toList()[i]) {
          list.add(selectColumns.keys.toList()[i]);
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

  void selectAllColumns() {
    _selectColumns = Map();
    _tableInfo.columnsByName.keys.forEach((item) {
      _selectColumns[item] = false;
    });
    createSqlQuery();
  }

  void onToggleColumn(String value) {
    final oldValue = _selectColumns[value];
    if (oldValue != null) {
      _selectColumns[value] = !oldValue;
      if (!selectColumns.values.contains(false)) {
        selectAllColumns();
      }
      createSqlQuery();
    }
  }

  FilterData copy() {
    final filterData = FilterData(_tableInfo);
    filterData._selectQuery = _selectQuery;
    filterData._limit = _limit;
    final map = Map<String, bool>();
    _selectColumns.forEach((key, value) => map[key] = value);
    filterData._selectColumns = map;
    filterData._customSqlQuery = _customSqlQuery;
    filterData._asc = _asc;
    filterData._orderingColumn = _orderingColumn;
    final whereClauses = _whereClauses.map((clause) => clause.copy()).toList();
    filterData._whereClauses = whereClauses;
    return filterData;
  }

  void onAscClicked() {
    _asc = true;
    createSqlQuery();
  }

  void onDescClicked() {
    _asc = false;
    createSqlQuery();
  }

  void onToggleOrderByColumn(String value) {
    if (_orderingColumn == value) {
      _orderingColumn = null;
    } else {
      _orderingColumn = value;
    }
    createSqlQuery();
  }

  void onWhereColumnSelected(String columnName) {
    if (!_tableInfo.columnsByName.containsKey(columnName)) return;
    final detail =
        _tableInfo.$columns.where((item) => item.$name == columnName).first;
    if (detail is GeneratedTextColumn) {
      _whereClauses.add(StringWhereClause(columnName));
    } else if (detail is GeneratedIntColumn) {
      _whereClauses.add(IntWhereClause(columnName));
    } else if (detail is GeneratedDateTimeColumn) {
      _whereClauses.add(DateWhereClause(columnName));
    } else if (detail is GeneratedBoolColumn) {
      _whereClauses.add(BoolWhereClause(columnName));
    } else if (detail is GeneratedRealColumn) {
      _whereClauses.add(DoubleWhereClause(columnName));
    } else if (detail is GeneratedBlobColumn) {
      _whereClauses.add(BlobWhereClause(columnName));
    } else {
      print('$detail is not yet supported');
    }
    createSqlQuery();
  }

  void onUpdatedWhereClause() {
    createSqlQuery();
  }

  void remove(WhereClause whereClause) {
    _whereClauses.remove(whereClause);
    createSqlQuery();
  }

  void updateCustomSqlQuery(String query) {
    _customSqlQuery = query;
    createSqlQuery();
  }

  void clearCustomSqlQuery() {
    _customSqlQuery = null;
    createSqlQuery();
  }
}
