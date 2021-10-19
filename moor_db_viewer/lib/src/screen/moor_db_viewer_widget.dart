import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:moor_db_viewer/src/model/db/moor_db_viewer_database.dart';
import 'package:moor_db_viewer/src/navigator/db_navigator.dart';

class MoorDbViewer extends StatefulWidget {
  final GeneratedDatabase db;

  MoorDbViewer(this.db);

  @override
  State<MoorDbViewer> createState() => _MoorDbViewerState();
}

class _MoorDbViewerState extends State<MoorDbViewer> {
  @override
  void initState() {
    MoorDbViewerDatabase.init(widget.db);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DbViewerNavigator();
}
