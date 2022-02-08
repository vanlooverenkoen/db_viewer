import 'package:db_viewer/src/model/db/db.dart';
import 'package:db_viewer/src/model/filter/filter_data.dart';
import 'package:db_viewer/src/screen/table_item_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TableItemDetailViewerViewModel with ChangeNotifier {
  late TableItemDetailViewerNavigator _navigator;
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

  Future<void> init(TableItemDetailViewerNavigator navigator,
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

abstract class TableItemDetailViewerNavigator {
  void showToast(String message);
}
