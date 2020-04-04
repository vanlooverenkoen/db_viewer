import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:moor_db_viewer/src/model/filter/filter_data.dart';
import 'package:moor_db_viewer/src/navigator/db_navigator.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/filter/filter_item_widget.dart';
import 'package:moor_db_viewer/src/widget/general/styled/styled_back_button.dart';
import 'package:moor_db_viewer/src/widget/provider/provider_widget.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class MoorTableFilterWidget extends StatefulWidget {
  static const routeName = 'moor-table-filter';

  final TableInfo<moor.Table, DataClass> table;
  final GeneratedDatabase db;
  final FilterData filterData;

  MoorTableFilterWidget(this.db, this.table, this.filterData);

  @override
  _MoorTableFilterWidgetState createState() => _MoorTableFilterWidgetState();
}

class _MoorTableFilterWidgetState extends State<MoorTableFilterWidget>
    implements MoorTableFilterNavigator {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MoorTableFilterViewModel>(
      consumer: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          leading: StyledBackButton(onBackClicked: viewModel.onBackClicked),
          title: Text(viewModel.title),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: viewModel.onAddFilterClicked,
            )
          ],
        ),
        body: ReorderableListView(
          onReorder: viewModel.changePositionOfFilters,
          children: [
            for (final filterItem in viewModel.filterData.filters)
              FilterItemWidget(
                key: ValueKey(filterItem),
                filterItem: filterItem,
                onRemove: () => viewModel.onRemove(filterItem),
                onEnableFilterChanged: (value) =>
                    viewModel.onEnableFilterChanged(filterItem, value),
              )
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
  void goToFilterSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select a new filter'),
        content: flutter.Column(
          children: [
            InkWell(
              child: Text('Search on column'),
            )
          ],
        ),
      ),
    );
  }
}
