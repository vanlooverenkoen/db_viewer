import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_limit_results_item.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class FilterLimitResultsViewModel with ChangeNotifier {
  // ignore: unused_field
  GeneratedDatabase _db;
  TableInfo<moor.Table, DataClass> _table;
  FilterLimitResultsItem _filterItem;

  final data = List<Map<String, dynamic>>();

  TextEditingController controller;

  bool get hasData => data.isNotEmpty;

  String get tableName => _table.entityName;

  FilterLimitResultsViewModel(this._db, this._table, this._filterItem) {
    controller = TextEditingController();
    controller.text = _filterItem.limit.toString();
    _getData();
  }

  Future<void> _getData() async {}

  void onLimitChanged(String value) {
    try {
      var stringIntValue = value;
      if (value == null || value.isEmpty) {
        stringIntValue = '0';
      }
      final parsedInt = int.parse(stringIntValue);
      _filterItem.setLimit(parsedInt);
      controller.text = parsedInt.toString();
      controller.selection = TextSelection.fromPosition(TextPosition(offset: parsedInt.toString().length));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
