import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/model/tuple.dart';
import 'package:moor_db_viewer/src/screen/moor_table_filter_widget.dart';
import 'package:moor_db_viewer/src/screen/moor_table_item_detail_viewer_widget.dart';
import 'package:moor_db_viewer/src/screen/moor_table_list_viewer_widget.dart';
import 'package:moor_db_viewer/src/screen/moor_table_content_list_viewer_widget.dart';
import 'package:moor_db_viewer/src/viewmodel/global_viewmodel.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';

class DbViewerNavigator extends StatefulWidget {
  const DbViewerNavigator({Key key}) : super(key: key);

  @override
  DbViewerNavigatorState createState() => DbViewerNavigatorState();

  static DbViewerNavigatorState of(context,
      {rootNavigator = false, nullOk = false}) {
    final DbViewerNavigatorState navigator = rootNavigator
        ? context.findRootAncestorStateOfType<DbViewerNavigatorState>()
        : context.findAncestorStateOfType<DbViewerNavigatorState>();
    assert(() {
      if (navigator == null && !nullOk) {
        throw FlutterError(
            'DbViewerNavigator operation requested with a context that does not include a DbViewerNavigator.\n'
            'The context used to push or pop routes from the DbViewerNavigator must be that of a '
            'widget that is a descendant of a DbViewerNavigator widget.');
      }
      return true;
    }());
    return navigator;
  }
}

class DbViewerNavigatorState extends State<DbViewerNavigator> {
  final _navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Navigator(
        key: _navigationKey,
        initialRoute: MoorTableListViewerWidget.routeName,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }

  Route onGenerateRoute(RouteSettings settings) {
    final canPop = Navigator.of(context).canPop();
    final globalViewModel =
        Provider.of<GlobalViewModel>(context, listen: false);
    final db = globalViewModel.db;
    switch (settings.name) {
      case MoorTableListViewerWidget.routeName:
        return MaterialPageRoute(
            builder: (context) => MoorTableListViewerWidget(db, canPop),
            settings: settings);
      case MoorTableContentListViewerWidget.routeName:
        final table = settings.arguments as TableInfo<moor.Table, DataClass>;
        return MaterialPageRoute(
            builder: (context) => MoorTableContentListViewerWidget(table),
            settings: settings);
      case MoorTableItemDetailViewerWidget.routeName:
        final table = settings.arguments as ItemDetailArgument;
        return MaterialPageRoute(
            builder: (context) => MoorTableItemDetailViewerWidget(table),
            settings: settings);
      case MoorTableFilterWidget.routeName:
        final tuple = settings.arguments
            as Tuple<TableInfo<moor.Table, DataClass>, FilterData>;
        return MaterialPageRoute<FilterData>(
            builder: (context) =>
                MoorTableFilterWidget(db, tuple.first, tuple.second),
            settings: settings);
      default:
        return null;
    }
  }

  Future<bool> _willPop() async =>
      !await _navigationKey.currentState.maybePop();

  void goToTableList() => _navigationKey.currentState
      .pushNamed(MoorTableListViewerWidget.routeName);

  void goToTableContentList(TableInfo<moor.Table, DataClass> table) =>
      _navigationKey.currentState.pushNamed(
          MoorTableContentListViewerWidget.routeName,
          arguments: table);

  void goToTableItemDetail(
          TableInfo<moor.Table, DataClass> table, Map<String, dynamic> data) =>
      _navigationKey.currentState.pushNamed(
          MoorTableItemDetailViewerWidget.routeName,
          arguments: ItemDetailArgument(table, data));

  Future<FilterData> goToTableFilter(
          TableInfo<moor.Table, DataClass> table, FilterData filterData) =>
      _navigationKey.currentState.pushNamed(MoorTableFilterWidget.routeName,
          arguments: Tuple(table, filterData));

  void goBack<T>({result}) {
    if (_navigationKey.currentState.canPop()) {
      _navigationKey.currentState.pop(result);
    } else {
      _goBackToTheApp();
    }
  }

  void _goBackToTheApp() => Navigator.of(context).pop();
}
