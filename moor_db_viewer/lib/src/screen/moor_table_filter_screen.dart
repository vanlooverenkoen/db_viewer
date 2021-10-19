import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/navigator/db_navigator.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/filter/where_widget.dart';
import 'package:provider/provider.dart';

class MoorTableFilterScreen extends StatefulWidget {
  static const routeName = 'moor-table-filter';

  final String tableName;
  final FilterData filterData;

  MoorTableFilterScreen(this.tableName, this.filterData);

  @override
  _MoorTableFilterScreenState createState() => _MoorTableFilterScreenState();
}

class _MoorTableFilterScreenState extends State<MoorTableFilterScreen> implements MoorTableFilterNavigator {
  final _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MoorTableFilterViewModel>(
      consumer: (context, viewModel, child) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: StyledBackButton(onBackClicked: viewModel.onBackClicked),
          title: Text(viewModel.title),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: viewModel.onSaveClicked,
            ),
          ],
        ),
        body: ListView(
          children: [
            SelectQueryWidget(
              query: viewModel.selectQuery,
              onEditClicked: viewModel.onEditClicked,
            ),
            if (viewModel.isEditedQuery)
              TextButton(
                child: Text('Clear custom sql statement'),
                onPressed: viewModel.oClearCustomSqlQueryClicked,
              ),
            AnimatedOpacity(
              opacity: viewModel.isEditedQuery ? 0.2 : 1,
              child: IgnorePointer(
                ignoring: viewModel.isEditedQuery,
                child: flutter.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectWidget(
                      areAllColumnsSelected: viewModel.areAllColumnsSelected,
                      columns: viewModel.selectColumns,
                      onSelectAll: viewModel.onSelectAllColumns,
                      onToggleColumn: viewModel.onToggleColumn,
                    ),
                    FromWidget(tableName: viewModel.tableName),
                    WhereTitleWidget(
                      onAddClicked: viewModel.onAddClicked,
                      whereClauses: viewModel.whereClauses,
                    ),
                    OrderByWidget(
                      columns: viewModel.orderByColumns,
                      onToggleColumn: viewModel.onToggleOrderByColumn,
                    ),
                    AscDescWidget(
                      asc: viewModel.asc,
                      onAscClicked: viewModel.onAscClicked,
                      onDescClicked: viewModel.onDescClicked,
                    ),
                    LimitWidget(limit: viewModel.limit),
                  ],
                ),
              ),
              duration: ThemeDurations.shortAnimationDuration(),
            ),
          ],
        ),
      ),
      create: () => MoorTableFilterViewModel(this, widget.tableName, widget.filterData),
    );
  }

  @override
  void goBack(FilterData? filterData) => DbViewerNavigator.of(context).goBack(result: filterData);

  @override
  Future<void> showAddWhereClause(String entityName) async {
    final theme = Theme.of(context);
    final db = DbViewerDatabase.instance();
    final columnNames = db.getColumnNamesByEntityName(entityName);
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(
          horizontal: ThemeDimens.padding8,
        ),
        backgroundColor: theme.dialogBackgroundColor,
        title: Text('Select column'),
        content: Container(
          width: MediaQuery.of(context).size.width - ThemeDimens.padding32,
          child: ListView.builder(
            itemCount: columnNames.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final columnName = columnNames[index];
              return ListTile(
                title: Text(
                  columnName,
                  style: theme.textTheme.headline6,
                ),
                subtitle: Text(
                  db.getType(entityName, columnName),
                  style: theme.textTheme.bodyText1,
                ),
                onTap: () => Navigator.of(context).pop(columnName),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
    final scaffoldContext = _scaffoldKey.currentContext;
    if (result != null && scaffoldContext != null) {
      Provider.of<MoorTableFilterViewModel>(
        scaffoldContext,
        listen: false,
      ).onWhereColumnSelected(result);
    }
  }

  @override
  Future<void> showEdit(String selectQuery) async {
    final result = await DbViewerNavigator.of(context).goToTableFilterEditSql(selectQuery);

    final scaffoldContext = _scaffoldKey.currentContext;
    if (result != null && scaffoldContext != null) {
      Provider.of<MoorTableFilterViewModel>(scaffoldContext, listen: false).onUpdateCustomSqlQuery(result);
    }
  }
}
