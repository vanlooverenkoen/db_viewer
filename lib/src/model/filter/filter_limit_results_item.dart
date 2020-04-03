import 'package:moor_db_viewer/src/model/filter/filter_item.dart';

class FilterLimitResultsItem extends FilterItem {
  var _limit = 20;

  int get limit => _limit;

  @override
  String get name => 'Limit results';

  @override
  bool get canBeDismissed => false;

  @override
  List<Map<String, dynamic>> applyFilter(List<Map<String, dynamic>> data) {
    if (data.length < _limit) return data;
    return data.sublist(0, _limit);
  }

  void setLimit(int limit) => _limit = limit;
}
