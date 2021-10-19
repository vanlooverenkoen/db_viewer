import 'package:db_viewer/db_viewer.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:drift_db_viewer/src/model/db/drift_db_viewer_database.dart';

class DriftDbViewer extends StatefulWidget {
  final GeneratedDatabase db;

  DriftDbViewer(this.db);

  @override
  State<DriftDbViewer> createState() => _DriftDbViewerState();
}

class _DriftDbViewerState extends State<DriftDbViewer> {
  @override
  void initState() {
    DriftDbViewerDatabase.init(widget.db);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DbViewerNavigator();
}
