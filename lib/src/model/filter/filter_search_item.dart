import 'package:moor_db_viewer/src/model/filter/filter_item.dart';

class FilterSearchItem extends FilterItem {
  String _searchQuery;
  String _columnName;

  @override
  String get name => 'Search';

  String get searchQuery => _searchQuery;

  String get columnName => _columnName;

  bool get hasFilter => _columnName != null && _searchQuery != null && _columnName.isNotEmpty && _searchQuery.isNotEmpty;

  void onUpdateSearchQuery(String searchQuery) {
    _searchQuery = searchQuery;
  }

  void onUpdateColumn(String column) {
    _columnName = column;
  }

  String getWhereClause() {
    return '$columnName LIKE \'%$_searchQuery%\'';
  }
}
