import 'package:db_viewer/db_viewer.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:drift_db_viewer/src/model/db/drift_db_viewer_database.dart';

class DriftDbViewer extends StatelessWidget {
  final GeneratedDatabase db;

  const DriftDbViewer(this.db, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DbViewerNavigator(database: DriftDbViewerDatabase(db));
  }
}
