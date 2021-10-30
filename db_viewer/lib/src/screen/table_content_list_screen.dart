import 'package:db_viewer/src/navigator/db_navigator.dart';
import 'package:db_viewer/src/style/theme_dimens.dart';
import 'package:db_viewer/src/viewmodel/table_content_list_viewer_viewmodel.dart';
import 'package:db_viewer/src/widget/error_widget.dart';
import 'package:db_viewer/src/widget/provider/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:db_viewer/src/model/filter/filter_data.dart';
import 'package:provider/provider.dart';

class TableContentListScreen extends StatefulWidget {
  static const routeName = 'table-content-list';

  final String tableName;

  TableContentListScreen(this.tableName);

  @override
  _TableContentListScreenState createState() => _TableContentListScreenState();
}

class _TableContentListScreenState extends State<TableContentListScreen>
    implements TableViewerNavigator {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ProviderWidget<TableContentListViewerViewModel>(
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
                          ? Theme.of(context).colorScheme.secondary
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
              return ErrorTextWidget(text: viewModel.error!);
            if (!viewModel.hasColumns && viewModel.hasData)
              return ErrorTextWidget(
                  text:
                      'No columns selected for the`${viewModel.tableName}` table');
            if (!viewModel.hasData && viewModel.hasCustomQuery)
              return ErrorTextWidget(
                  text:
                      'No data found for your current filter on the `${viewModel.tableName}` table');
            if (!viewModel.hasData)
              return ErrorTextWidget(
                  text: 'No data added to the `${viewModel.tableName}` table');
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 0,
                  columns: [
                    for (final item in viewModel.data[0].keys)
                      DataColumn(
                        label: Text(
                          item,
                          style: theme.textTheme.headline6,
                        ),
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
                                        style: theme.textTheme.bodyText1,
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
      create: () =>
          TableContentListViewerViewModel()..init(this, widget.tableName),
    );
  }

  @override
  Future<void> goToFilter(
    String table,
    FilterData filteredData,
  ) async {
    final newFilterData = await DbViewerNavigator.of(context)
        .goToTableFilter(table, filteredData);
    final scaffoldContext = _key.currentContext;
    if (newFilterData != null && scaffoldContext != null) {
      Provider.of<TableContentListViewerViewModel>(
        scaffoldContext,
        listen: false,
      ).updateFilter(newFilterData);
    }
  }

  @override
  void goToItemDetail(
    String tableName,
    Map<String, dynamic> data,
  ) =>
      DbViewerNavigator.of(context).goToTableItemDetail(tableName, data);

  @override
  void showToast(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );

    final scaffoldContext = _key.currentContext;
    if (scaffoldContext != null) {
      ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
    }
  }
}
