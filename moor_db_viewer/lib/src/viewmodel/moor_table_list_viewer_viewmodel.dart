import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';

class MoorTableListViewerViewModel with ChangeNotifier {
  late MoorTableListViewerNavigator _navigator;
  late DbViewerDatabase database;

  late List<String> _tableNames;

  List<String> get tableNames => _tableNames;

  Future<void> init(MoorTableListViewerNavigator navigator, DbViewerDatabase databaseAccessor) async {
    _navigator = navigator;
    database = databaseAccessor;
    _getTables();
    notifyListeners();
  }

  void _getTables() => _tableNames = database.tableNames;

  void onTableClicked(String tableName) => _navigator.goToTableDetail(tableName);
}

abstract class MoorTableListViewerNavigator {
  void goToTableDetail(String tableName);
}
