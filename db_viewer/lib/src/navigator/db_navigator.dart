import 'package:db_viewer/src/model/filter/filter_data.dart';
import 'package:db_viewer/src/model/tuple.dart';
import 'package:db_viewer/src/screen/table_content_list_screen.dart';
import 'package:db_viewer/src/screen/table_filter_edit_query_screen.dart';
import 'package:db_viewer/src/screen/table_filter_screen.dart';
import 'package:db_viewer/src/screen/table_item_detail_screen.dart';
import 'package:db_viewer/src/screen/table_list_screen.dart';
import 'package:flutter/material.dart';

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
        initialRoute: TableListScreen.routeName,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }

  Route? onGenerateRoute(RouteSettings settings) {
    final canPop = Navigator.of(context).canPop();
    switch (settings.name) {
      case TableListScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => TableListScreen(canPop), settings: settings);
      case TableContentListScreen.routeName:
        final tableName = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => TableContentListScreen(tableName),
            settings: settings);
      case TableItemDetailScreen.routeName:
        final table = settings.arguments as ItemDetailArgument;
        return MaterialPageRoute(
            builder: (context) => TableItemDetailScreen(table),
            settings: settings);
      case TableFilterScreen.routeName:
        final tuple = settings.arguments as DbViewerTuple<String, FilterData>;
        return MaterialPageRoute<FilterData>(
            builder: (context) => TableFilterScreen(tuple.first, tuple.second),
            settings: settings);
      case TableFilterEditQueryScreen.routeName:
        final query = settings.arguments as String;
        return MaterialPageRoute<String>(
            builder: (context) => TableFilterEditQueryScreen(query),
            settings: settings);
      default:
        return null;
    }
  }

  Future<bool> _willPop() async =>
      !await _navigationKey.currentState!.maybePop();

  void goToTableList() =>
      _navigationKey.currentState!.pushNamed(TableListScreen.routeName);

  void goToTableContentList(String tableName) {
    _navigationKey.currentState!.pushNamed(
      TableContentListScreen.routeName,
      arguments: tableName,
    );
  }

  void goToTableItemDetail(
    String tableName,
    Map<String, dynamic> data,
  ) {
    _navigationKey.currentState!.pushNamed(
      TableItemDetailScreen.routeName,
      arguments: ItemDetailArgument(tableName, data),
    );
  }

  Future<FilterData?>? goToTableFilter(
    String tableName,
    FilterData filterData,
  ) {
    return _navigationKey.currentState!.pushNamed<FilterData>(
      TableFilterScreen.routeName,
      arguments: DbViewerTuple(tableName, filterData),
    );
  }

  Future<String?>? goToTableFilterEditSql(String query) {
    return _navigationKey.currentState!.pushNamed(
      TableFilterEditQueryScreen.routeName,
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
