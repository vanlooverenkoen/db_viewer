import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';

class MoorTableListViewerViewModel with ChangeNotifier {
  late MoorTableListViewerNavigator _navigator;

  late List<String> _tableNames;

  List<String> get tableNames => _tableNames;

  DbViewerDatabase get _db => DbViewerDatabase.instance();

  Future<void> init(MoorTableListViewerNavigator navigator) async {
    _navigator = navigator;
    _getTables();
    notifyListeners();
  }

  void _getTables() => _tableNames = _db.tableNames;

  void onTableClicked(String tableName) => _navigator.goToTableDetail(tableName);
}

abstract class MoorTableListViewerNavigator {
  void goToTableDetail(String tableName);
}
