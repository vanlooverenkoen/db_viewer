import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class MoorTableListViewerViewModel with ChangeNotifier {
  MoorTableListViewerNavigator _navigator;
  GeneratedDatabase _databaseAccessor;

  List<TableInfo<moor.Table, DataClass>> tables;

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

  void onTableClicked(TableInfo<moor.Table, DataClass> table) {
    _navigator.goToTableDetail(table);
  }
}

abstract class MoorTableListViewerNavigator {
  void goToTableDetail(TableInfo<moor.Table, DataClass> table);
}
