import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/navigator/db_navigator.dart';
import 'package:moor_db_viewer/src/viewmodel/moor_table_list_viewer_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/general/styled/styled_back_button.dart';
import 'package:moor_db_viewer/src/widget/general/table_row_item.dart';
import 'package:moor_db_viewer/src/widget/provider/provider_widget.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class MoorTableListScreen extends StatefulWidget {
  static const routeName = 'moor-table-list';

  final GeneratedDatabase db;
  final bool canPop;

  MoorTableListScreen(this.db, this.canPop);

  @override
  _MoorTableListScreenState createState() => _MoorTableListScreenState();
}

class _MoorTableListScreenState extends State<MoorTableListScreen>
    implements MoorTableListViewerNavigator {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MoorTableListViewerViewModel>(
      consumer: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          leading: widget.canPop
              ? StyledBackButton(
                  onBackClicked: DbViewerNavigator.of(context).goBack)
              : Container(),
          title: Text('Tables'),
        ),
        body: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: viewModel.tables.length,
          itemBuilder: (context, index) {
            final table = viewModel.tables[index];
            return TableRowItem(
              table: table,
              onClick: () => viewModel.onTableClicked(table),
            );
          },
        ),
      ),
      create: () => MoorTableListViewerViewModel()..init(this, widget.db),
    );
  }

  @override
  void goToTableDetail(TableInfo<moor.Table, DataClass> table) =>
      DbViewerNavigator.of(context).goToTableContentList(table);
}
