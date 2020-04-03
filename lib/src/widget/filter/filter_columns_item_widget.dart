import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:moor_db_viewer/src/model/filter/filter_column_item.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/items/filter_columns_viewmodel.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/viewmodel/global_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/general/single_selectable_filter_item.dart';
import 'package:moor_db_viewer/src/widget/provider/provider_widget.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';

class FilterColumnsItemWidget extends StatelessWidget {
  final FilterColumnsItem filterItem;

  FilterColumnsItemWidget({@required this.filterItem});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FilterColumnsViewModel>(
      consumer: (context, viewModel, child) {
        if (viewModel.columns.length > 20) {
          return Container(
            height: 350,
            child: ListView.builder(
              itemCount: viewModel.columns.length,
              itemBuilder: (context, index) => getItem(context, viewModel, viewModel.columns[index]),
            ),
          );
        }
        return flutter.Column(
          children: [
            for (final column in viewModel.columns) getItem(context, viewModel, column),
          ],
        );
      },
      create: () => FilterColumnsViewModel(
        Provider.of<GlobalViewModel>(context).db,
        Provider.of<MoorTableFilterViewModel>(context).table,
        filterItem,
      ),
    );
  }
}

Widget getItem(BuildContext context, FilterColumnsViewModel viewModel, GeneratedColumn column) {
  return SingleSelectableFilterItem.checkbox(
    value: viewModel.isColumnSelected(column),
    title: Text(column.$name),
    onChanged: (value) => viewModel.onColumnSelectionChanged(column, value),
  );
}
