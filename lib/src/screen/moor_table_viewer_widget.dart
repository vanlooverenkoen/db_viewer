import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/navigator/db_navigator.dart';
import 'package:moor_db_viewer/src/viewmodel/global_viewmodel.dart';
import 'package:moor_db_viewer/src/viewmodel/moor_table_viewer_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/provider/provider_widget.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';

class MoorTableViewerWidget extends StatefulWidget {
  static const routeName = 'moor-table-detail';

  final TableInfo<moor.Table, DataClass> table;

  MoorTableViewerWidget(this.table);

  @override
  _MoorTableViewerWidgetState createState() => _MoorTableViewerWidgetState();
}

class _MoorTableViewerWidgetState extends State<MoorTableViewerWidget> implements MoorTableViewerNavigator {
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MoorTableViewerViewModel>(
      consumer: (context, viewModel, child) => Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(viewModel.title),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: viewModel.onFilterClicked,
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (!viewModel.hasColumns && viewModel.hasData) return Center(child: Text('No columns selected for the`${viewModel.tableName}` table'));
            if (!viewModel.hasData) return Center(child: Text('No data added to the `${viewModel.tableName}` table'));
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    for (final item in viewModel.filteredData[0].keys)
                      DataColumn(
                        label: Text(item),
                      ),
                  ],
                  rows: [
                    ...viewModel.filteredData.map((item) => DataRow(
                          cells: [
                            ...item.keys.map(
                              (key) => DataCell(
                                Text(item[key].toString()),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      create: () => MoorTableViewerViewModel()..init(this, Provider.of<GlobalViewModel>(context).db, widget.table),
    );
  }

  @override
  Future<void> goToFilter(TableInfo<moor.Table, DataClass> table, FilterData filteredData) async {
    final newFilterData = await DbViewerNavigator.of(context).goToTableFilter(table, filteredData);
    if (newFilterData == null) return;
    Provider.of<MoorTableViewerViewModel>(_key.currentContext, listen: false).updateFilter(newFilterData);
  }
}
