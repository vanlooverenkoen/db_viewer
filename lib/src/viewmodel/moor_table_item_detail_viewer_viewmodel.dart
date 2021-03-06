import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moor/moor.dart';
import 'package:moor/moor.dart' as moor;
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/repo/caching/caching_repository.dart';
import 'package:moor_db_viewer/src/screen/moor_table_item_detail_screen.dart';

class MoorTableItemDetailViewerViewModel with ChangeNotifier {
  late MoorTableItemDetailViewerNavigator _navigator;
  late TableInfo<moor.Table, DataClass> _table;
  final cachingRepo = CachingRepository.instance();

  Map<String, dynamic> _data = Map();
  late FilterData _filteredData;

  int totalResults = 0;

  String? error;

  bool get hasFilter => _filteredData.hasCustomQuery;

  Map<String, dynamic> get data => _data;

  bool get hasData => _data.isNotEmpty;

  String get title => 'Detail';

  String get tableName => _table.entityName;

  int get amountOfColumns => _data.keys.length;

  Future<void> init(MoorTableItemDetailViewerNavigator navigator,
      ItemDetailArgument arguments) async {
    _navigator = navigator;
    _data = arguments.data;
    _table = arguments.table;
    _filteredData = cachingRepo.getFilterDataForTable(_table);
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
