import 'package:moor_db_viewer/src/model/filter/filter_item.dart';
import 'package:moor_flutter/moor_flutter.dart';

class FilterLimitResultsItem extends FilterItem {
  var _limit = 20;

  int get limit => _limit;

  @override
  String get name => 'Limit results';

  @override
  bool get canBeDismissed => false;

  void setLimit(int limit) => _limit = limit;
}
