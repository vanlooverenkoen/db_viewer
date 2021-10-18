import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:moor_db_viewer/src/navigator/db_navigator.dart';
import 'package:moor_db_viewer/src/viewmodel/global_viewmodel.dart';

class MoorDbViewer extends StatelessWidget {
  final GeneratedDatabase db;

  MoorDbViewer(this.db);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<GlobalViewModel>(
      child: DbViewerNavigator(),
      create: () => GlobalViewModel(db),
    );
  }
}
