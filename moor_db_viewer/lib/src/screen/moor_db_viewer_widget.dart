import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:moor_db_viewer/src/model/db/moor_db_viewer_database.dart';
import 'package:moor_db_viewer/src/navigator/db_navigator.dart';
import 'package:moor_db_viewer/src/repo/caching/caching_repository.dart';
import 'package:moor_db_viewer/src/viewmodel/global_viewmodel.dart';

class MoorDbViewer extends StatefulWidget {
  final GeneratedDatabase db;

  MoorDbViewer(this.db);

  @override
  State<MoorDbViewer> createState() => _MoorDbViewerState();
}

class _MoorDbViewerState extends State<MoorDbViewer> {
  late MoorDbViewerDatabase db;

  @override
  void initState() {
    db = MoorDbViewerDatabase(widget.db);
    CachingRepository.init(db);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<GlobalViewModel>(
      child: DbViewerNavigator(),
      create: () => GlobalViewModel(db),
    );
  }
}
