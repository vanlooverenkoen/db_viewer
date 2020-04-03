import 'package:moor_db_viewer/src/model/filter/filter_item.dart';

class FilterSearchItem extends FilterItem {
  String _searchQuery;
  String _column;

  @override
  String get name => 'Search';

  String get searchQuery => _searchQuery;

  String get column => _column;

  @override
  List<Map<String, dynamic>> applyFilter(List<Map<String, dynamic>> data) {
    if (_column == null || _searchQuery == null || _column.isEmpty || _searchQuery.isEmpty) return data;

    data.removeWhere((item) {
      if (!item.containsKey(_column)) return true;
      return !item[_column].toString().contains(_searchQuery);
    });
    return data;
  }

  void onUpdateSearchQuery(String searchQuery) {
    _searchQuery = searchQuery;
  }

  void onUpdateColumn(String column) {
    _column = column;
  }
}
