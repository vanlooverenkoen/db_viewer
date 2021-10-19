import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/screen/moor_table_item_detail_screen.dart';

class MoorTableItemDetailViewerViewModel with ChangeNotifier {
  late MoorTableItemDetailViewerNavigator _navigator;
  late String _tableName;

  Map<String, dynamic> _data = Map();
  late FilterData _filteredData;

  int totalResults = 0;

  String? error;

  bool get hasFilter => _filteredData.hasCustomQuery;

  Map<String, dynamic> get data => _data;

  bool get hasData => _data.isNotEmpty;

  String get title => 'Detail';

  String get tableName => _tableName;

  int get amountOfColumns => _data.keys.length;

  DbViewerDatabase get _db => DbViewerDatabase.instance();

  Future<void> init(MoorTableItemDetailViewerNavigator navigator,
      ItemDetailArgument arguments) async {
    _navigator = navigator;
    _data = arguments.data;
    _tableName = arguments.tableName;
    _filteredData = _db.getCachedFilterData(_tableName);
  }

  void onLongPressValue(item) {
    final clipboardData = ClipboardData(text: item.toString());
    Clipboard.setData(clipboardData);
    _navigator.showToast('Copied `${item.toString()}` to your clipboard');
  }

  String getKey(int index) => _data.keys.toList()[index];

  String getValue(int index) => _data.values.toList()[index].toString();
}

abstract class MoorTableItemDetailViewerNavigator {
  void showToast(String message);
}
