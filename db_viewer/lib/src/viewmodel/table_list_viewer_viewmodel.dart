import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';

class TableListViewerViewModel with ChangeNotifier {
  late TableListViewerNavigator _navigator;

  late List<String> _tableNames;

  List<String> get tableNames => _tableNames;

  DbViewerDatabase get _db => DbViewerDatabase.instance();

  Future<void> init(TableListViewerNavigator navigator) async {
    _navigator = navigator;
    _getTables();
    notifyListeners();
  }

  void _getTables() {
    _tableNames = _db.entityNames;
    _tableNames.sort((a1, a2) => a1.compareTo(a2));
  }

  void onTableClicked(String tableName) =>
      _navigator.goToTableDetail(tableName);
}

abstract class TableListViewerNavigator {
  void goToTableDetail(String tableName);
}
