import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/navigator/db_navigator.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/style/theme_durations.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/filter/asc_desc_widget.dart';
import 'package:moor_db_viewer/src/widget/filter/from_widget.dart';
import 'package:moor_db_viewer/src/widget/filter/limit_widget.dart';
import 'package:moor_db_viewer/src/widget/filter/order_by_widget.dart';
import 'package:moor_db_viewer/src/widget/filter/select_query_widget.dart';
import 'package:moor_db_viewer/src/widget/filter/select_widget.dart';
import 'package:moor_db_viewer/src/widget/filter/where_widget.dart';
import 'package:moor_db_viewer/src/widget/general/styled/styled_back_button.dart';
import 'package:moor_db_viewer/src/widget/provider/provider_widget.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';

class MoorTableFilterScreen extends StatefulWidget {
  static const routeName = 'moor-table-filter';

  final TableInfo<moor.Table, DataClass> table;
  final GeneratedDatabase db;
  final FilterData filterData;

  MoorTableFilterScreen(this.db, this.table, this.filterData);

  @override
  _MoorTableFilterScreenState createState() => _MoorTableFilterScreenState();
}

class _MoorTableFilterScreenState extends State<MoorTableFilterScreen>
    implements MoorTableFilterNavigator {
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
              FlatButton(
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
      create: () => MoorTableFilterViewModel(
          this, widget.db, widget.table, widget.filterData),
    );
  }

  @override
  void goBack(FilterData filterData) =>
      DbViewerNavigator.of(context).goBack(result: filterData);

  @override
  Future<void> showAddWhereClause(
      TableInfo<moor.Table, DataClass> table) async {
    final columnNames = table.columnsByName.keys.toList();
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(
          horizontal: ThemeDimens.padding8,
        ),
        title: Text('Select column'),
        content: Container(
          width: MediaQuery.of(context).size.width - ThemeDimens.padding32,
          child: ListView.builder(
            itemCount: columnNames.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final columnName = columnNames[index];
              return ListTile(
                title: Text(columnName),
                subtitle: Text(getType(table.$columns
                    .firstWhere((column) => column.$name == columnName))),
                onTap: () => Navigator.of(context).pop(columnName),
              );
            },
          ),
        ),
        actions: [
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
    if (result != null)
      Provider.of<MoorTableFilterViewModel>(_scaffoldKey.currentContext,
              listen: false)
          .onWhereColumnSelected(result);
  }

  String getType(GeneratedColumn column) {
    if (column is GeneratedDateTimeColumn) {
      return 'DATE';
    } else if (column is GeneratedBlobColumn) {
      return 'BLOB';
    } else if (column is GeneratedRealColumn) {
      return 'DOUBLE';
    } else if (column is GeneratedBoolColumn) {
      return 'BOOL';
    } else if (column is GeneratedTextColumn) {
      return 'TEXT';
    } else if (column is IntColumn) {
      return 'INTEGER';
    }
    return 'UNSUPPORTED TYPE';
  }

  @override
  Future<void> showEdit(String selectQuery) async {
    final result =
        await DbViewerNavigator.of(context).goToTableFilterEditSql(selectQuery);
    if (result != null)
      Provider.of<MoorTableFilterViewModel>(_scaffoldKey.currentContext,
              listen: false)
          .onUpdateCustomSqlQuery(result);
  }
}
