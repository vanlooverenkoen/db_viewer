import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:moor/moor.dart' as moor;

class MoorTableListViewerViewModel with ChangeNotifier {
  late MoorTableListViewerNavigator _navigator;
  late GeneratedDatabase _databaseAccessor;

  late List<TableInfo<moor.Table, dynamic>> tables;

  Future<void> init(MoorTableListViewerNavigator navigator,
      GeneratedDatabase databaseAccessor) async {
    _navigator = navigator;
    _databaseAccessor = databaseAccessor;
    _getTables();
    notifyListeners();
  }

  void _getTables() {
    tables = _databaseAccessor.allTables.map((item) => item).toList();
  }

  void onTableClicked(TableInfo<moor.Table, dynamic> table) {
    _navigator.goToTableDetail(table);
  }
}

abstract class MoorTableListViewerNavigator {
  void goToTableDetail(TableInfo<moor.Table, dynamic> table);
}
