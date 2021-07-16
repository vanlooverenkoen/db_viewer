import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:moor/moor.dart' as moor;
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/model/tuple.dart';
import 'package:moor_db_viewer/src/screen/moor_table_content_list_screen.dart';
import 'package:moor_db_viewer/src/screen/moor_table_filter_edit_sql_screen.dart';
import 'package:moor_db_viewer/src/screen/moor_table_filter_screen.dart';
import 'package:moor_db_viewer/src/screen/moor_table_item_detail_screen.dart';
import 'package:moor_db_viewer/src/screen/moor_table_list_screen.dart';
import 'package:moor_db_viewer/src/viewmodel/global_viewmodel.dart';
import 'package:provider/provider.dart';

class DbViewerNavigator extends StatefulWidget {
  const DbViewerNavigator({Key? key}) : super(key: key);

  @override
  DbViewerNavigatorState createState() => DbViewerNavigatorState();

  static DbViewerNavigatorState of(
    BuildContext context, {
    rootNavigator = false,
  }) {
    final DbViewerNavigatorState? navigator = rootNavigator
        ? context.findRootAncestorStateOfType<DbViewerNavigatorState>()
        : context.findAncestorStateOfType<DbViewerNavigatorState>();

    assert(() {
      if (navigator == null) {
        throw FlutterError(
            'DbViewerNavigator operation requested with a context that does not include a DbViewerNavigator.\n'
            'The context used to push or pop routes from the DbViewerNavigator must be that of a '
            'widget that is a descendant of a DbViewerNavigator widget.');
      }
      return true;
    }());

    return navigator!;
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
        initialRoute: MoorTableListScreen.routeName,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }

  Route? onGenerateRoute(RouteSettings settings) {
    final canPop = Navigator.of(context).canPop();
    final globalViewModel =
        Provider.of<GlobalViewModel>(context, listen: false);
    final db = globalViewModel.db;
    switch (settings.name) {
      case MoorTableListScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => MoorTableListScreen(db, canPop),
            settings: settings);
      case MoorTableContentListScreen.routeName:
        final table = settings.arguments as TableInfo<moor.Table, dynamic>;
        return MaterialPageRoute(
            builder: (context) => MoorTableContentListScreen(table),
            settings: settings);
      case MoorTableItemDetailScreen.routeName:
        final table = settings.arguments as ItemDetailArgument;
        return MaterialPageRoute(
            builder: (context) => MoorTableItemDetailScreen(table),
            settings: settings);
      case MoorTableFilterScreen.routeName:
        final tuple = settings.arguments
            as Tuple<TableInfo<moor.Table, dynamic>, FilterData>;
        return MaterialPageRoute<FilterData>(
            builder: (context) =>
                MoorTableFilterScreen(db, tuple.first, tuple.second),
            settings: settings);
      case MoorTableFilterEditSqlScreen.routeName:
        final query = settings.arguments as String;
        return MaterialPageRoute<String>(
            builder: (context) => MoorTableFilterEditSqlScreen(query),
            settings: settings);
      default:
        return null;
    }
  }

  Future<bool> _willPop() async =>
      !await _navigationKey.currentState!.maybePop();

  void goToTableList() =>
      _navigationKey.currentState!.pushNamed(MoorTableListScreen.routeName);

  void goToTableContentList(TableInfo<moor.Table, dynamic> table) {
    _navigationKey.currentState!.pushNamed(
      MoorTableContentListScreen.routeName,
      arguments: table,
    );
  }

  void goToTableItemDetail(
    TableInfo<moor.Table, dynamic> table,
    Map<String, dynamic> data,
  ) {
    _navigationKey.currentState!.pushNamed(
      MoorTableItemDetailScreen.routeName,
      arguments: ItemDetailArgument(table, data),
    );
  }

  Future<FilterData?>? goToTableFilter(
    TableInfo<moor.Table, dynamic> table,
    FilterData filterData,
  ) {
    return _navigationKey.currentState!.pushNamed<FilterData>(
      MoorTableFilterScreen.routeName,
      arguments: Tuple(table, filterData),
    );
  }

  Future<String?>? goToTableFilterEditSql(String query) {
    return _navigationKey.currentState!.pushNamed(
      MoorTableFilterEditSqlScreen.routeName,
      arguments: query,
    );
  }

  void goBack<T>({result}) {
    if (_navigationKey.currentState!.canPop()) {
      _navigationKey.currentState!.pop(result);
    } else {
      _goBackToTheApp();
    }
  }

  void _goBackToTheApp() => Navigator.of(context).pop();
}
