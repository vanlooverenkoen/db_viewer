import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';

class GlobalViewModel with ChangeNotifier {
  final DbViewerDatabase db;

  GlobalViewModel(this.db);
}
