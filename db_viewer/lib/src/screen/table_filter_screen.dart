import 'package:db_viewer/src/model/db/db.dart';
import 'package:db_viewer/src/navigator/db_navigator.dart';
import 'package:db_viewer/src/style/theme_dimens.dart';
import 'package:db_viewer/src/style/theme_durations.dart';
import 'package:db_viewer/src/viewmodel/filter/table_filter_viewmodel.dart';
import 'package:db_viewer/src/widget/filter/asc_desc_widget.dart';
import 'package:db_viewer/src/widget/filter/from_widget.dart';
import 'package:db_viewer/src/widget/filter/limit_widget.dart';
import 'package:db_viewer/src/widget/filter/order_by_widget.dart';
import 'package:db_viewer/src/widget/filter/select_query_widget.dart';
import 'package:db_viewer/src/widget/filter/select_widget.dart';
import 'package:db_viewer/src/widget/general/styled/styled_back_button.dart';
import 'package:db_viewer/src/widget/provider/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:db_viewer/src/model/filter/filter_data.dart';
import 'package:provider/provider.dart';

class TableFilterScreen extends StatefulWidget {
  static const routeName = 'table-filter';

  final String tableName;
  final FilterData filterData;

  const TableFilterScreen(
    this.tableName,
    this.filterData, {
    Key? key,
  }) : super(key: key);

  @override
  _TableFilterScreenState createState() => _TableFilterScreenState();
}

class _TableFilterScreenState extends State<TableFilterScreen>
    implements TableFilterNavigator {
  final _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TableFilterViewModel>(
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
                    DbViewerDatabase.instance().buildWhereWidget(
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
      create: () =>
          TableFilterViewModel(this, widget.tableName, widget.filterData),
    );
  }

  @override
  void goBack(FilterData? filterData) =>
      DbViewerNavigator.of(context).goBack(result: filterData);

  @override
  Future<void> showAddWhereClause(String entityName) async {
    final theme = Theme.of(context);
    final db = DbViewerDatabase.instance();
    final columnNames = db.getColumnNamesByEntityName(entityName);
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: ThemeDimens.padding8,
        ),
        backgroundColor: theme.dialogBackgroundColor,
        title: const Text('Select column'),
        content: SizedBox(
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
      Provider.of<TableFilterViewModel>(
        scaffoldContext,
        listen: false,
      ).onWhereColumnSelected(result);
    }
  }

  @override
  Future<void> showEdit(String selectQuery) async {
    final result =
        await DbViewerNavigator.of(context).goToTableFilterEditSql(selectQuery);

    final scaffoldContext = _scaffoldKey.currentContext;
    if (result != null && scaffoldContext != null) {
      Provider.of<TableFilterViewModel>(scaffoldContext, listen: false)
          .onUpdateCustomSqlQuery(result);
    }
  }
}
