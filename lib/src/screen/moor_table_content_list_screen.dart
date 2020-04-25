import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/navigator/db_navigator.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/viewmodel/global_viewmodel.dart';
import 'package:moor_db_viewer/src/viewmodel/moor_table_content_list_viewer_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/provider/provider_widget.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';

class MoorTableContentListScreen extends StatefulWidget {
  static const routeName = 'moor-table-content-list';

  final TableInfo<moor.Table, DataClass> table;

  MoorTableContentListScreen(this.table);

  @override
  _MoorTableContentListScreenState createState() =>
      _MoorTableContentListScreenState();
}

class _MoorTableContentListScreenState extends State<MoorTableContentListScreen>
    implements MoorTableViewerNavigator {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MoorTableContentListViewerViewModel>(
      consumer: (context, viewModel, child) => Scaffold(
        key: _key,
        appBar: AppBar(
          centerTitle: Theme.of(context).platform == TargetPlatform.iOS,
          title: Text(viewModel.title),
          actions: [
            Stack(
              children: [
                Center(
                  child: IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: viewModel.onFilterClicked,
                  ),
                ),
                Positioned(
                  top: ThemeDimens.padding16,
                  right: ThemeDimens.padding12,
                  child: Container(
                    height: ThemeDimens.padding8,
                    width: ThemeDimens.padding8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: viewModel.hasCustomQuery
                          ? Theme.of(context).accentColor
                          : Colors.transparent,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (viewModel.error != null)
              return Center(child: Text(viewModel.error));
            if (!viewModel.hasColumns && viewModel.hasData)
              return Center(
                  child: Text(
                      'No columns selected for the`${viewModel.tableName}` table'));
            if (!viewModel.hasData && viewModel.hasCustomQuery)
              return Center(
                  child: Text(
                      'No data found for your current filter on the `${viewModel.tableName}` table'));
            if (!viewModel.hasData)
              return Center(
                  child: Text(
                      'No data added to the `${viewModel.tableName}` table'));
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 0,
                  columns: [
                    for (final item in viewModel.data[0].keys)
                      DataColumn(
                        label: Text(item),
                      ),
                  ],
                  rows: [
                    ...viewModel.data.map(
                      (item) => DataRow(
                        cells: [
                          ...item.keys.map(
                            (key) => DataCell(
                              GestureDetector(
                                child: Container(
                                  color: Colors.transparent,
                                  height: ThemeDimens.padding48,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: ThemeDimens.padding32),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item[key].toString(),
                                      ),
                                    ),
                                  ),
                                ),
                                onLongPress: () =>
                                    viewModel.onLongPressValue(item[key]),
                                onTap: () => viewModel.onItemClicked(item),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      create: () => MoorTableContentListViewerViewModel()
        ..init(this, Provider.of<GlobalViewModel>(context).db, widget.table),
    );
  }

  @override
  Future<void> goToFilter(
      TableInfo<moor.Table, DataClass> table, FilterData filteredData) async {
    final newFilterData = await DbViewerNavigator.of(context)
        .goToTableFilter(table, filteredData);
    if (newFilterData == null) return;
    Provider.of<MoorTableContentListViewerViewModel>(_key.currentContext,
            listen: false)
        .updateFilter(newFilterData);
  }

  @override
  void goToItemDetail(
          TableInfo<moor.Table, DataClass> table, Map<String, dynamic> data) =>
      DbViewerNavigator.of(context).goToTableItemDetail(table, data);

  @override
  void showToast(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );
    _key.currentState.showSnackBar(snackBar);
  }
}
