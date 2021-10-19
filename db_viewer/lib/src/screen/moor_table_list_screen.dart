import 'package:db_viewer/src/navigator/db_navigator.dart';
import 'package:db_viewer/src/viewmodel/moor_table_list_viewer_viewmodel.dart';
import 'package:db_viewer/src/widget/general/styled/styled_back_button.dart';
import 'package:db_viewer/src/widget/general/table_row_item.dart';
import 'package:db_viewer/src/widget/provider/provider_widget.dart';
import 'package:flutter/material.dart';

class MoorTableListScreen extends StatefulWidget {
  static const routeName = 'moor-table-list';

  final bool canPop;

  const MoorTableListScreen(
    this.canPop, {
    Key? key,
  }) : super(key: key);

  @override
  _MoorTableListScreenState createState() => _MoorTableListScreenState();
}

class _MoorTableListScreenState extends State<MoorTableListScreen> implements MoorTableListViewerNavigator {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MoorTableListViewerViewModel>(
      consumer: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          leading: widget.canPop ? StyledBackButton(onBackClicked: DbViewerNavigator.of(context).goBack) : Container(),
          title: Text('Tables'),
        ),
        body: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: viewModel.tableNames.length,
          itemBuilder: (context, index) {
            final table = viewModel.tableNames[index];
            return TableRowItem(
              tableName: table,
              onClick: () => viewModel.onTableClicked(table),
            );
          },
        ),
      ),
      create: () => MoorTableListViewerViewModel()..init(this),
    );
  }

  @override
  void goToTableDetail(String tableName) => DbViewerNavigator.of(context).goToTableContentList(tableName);
}
