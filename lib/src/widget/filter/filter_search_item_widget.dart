import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:moor_db_viewer/src/app_constants.dart';
import 'package:moor_db_viewer/src/model/filter/filter_search_item.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/items/filter_search_viewmodel.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/viewmodel/global_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/general/single_selectable_filter_item.dart';
import 'package:moor_db_viewer/src/widget/general/styled/styled_text_field.dart';
import 'package:moor_db_viewer/src/widget/provider/provider_widget.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';

class FilterSearchItemWidget extends StatelessWidget {
  final FilterSearchItem filterItem;

  FilterSearchItemWidget({@required this.filterItem});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FilterSearchViewModel>(
      consumer: (context, viewModel, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: ThemeDimens.padding16),
        child: flutter.Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            StyledTextField(
                controller: viewModel.controller,
                hint: 'Enter search query',
                onChanged: viewModel.onSearchQueryChanged),
            Container(height: ThemeDimens.padding8),
            Text('Select Column:'),
            getColumns(context, viewModel),
            Container(height: ThemeDimens.padding16),
          ],
        ),
      ),
      create: () => FilterSearchViewModel(
        Provider.of<GlobalViewModel>(context).db,
        Provider.of<MoorTableFilterViewModel>(context).table,
        filterItem,
      ),
    );
  }

  Widget getColumns(BuildContext context, FilterSearchViewModel viewModel) {
    if (viewModel.columns.length > AppConstants.MAX_ITEMS) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: viewModel.columns.length,
          itemBuilder: (context, index) {
            final column = viewModel.columns[index];
            return getItem(context, viewModel, column);
          },
        ),
      );
    }
    return flutter.Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final column in viewModel.columns)
          getItem(context, viewModel, column),
      ],
    );
  }

  Widget getItem(BuildContext context, FilterSearchViewModel viewModel,
      GeneratedColumn column) {
    return SingleSelectableFilterItem.checkmark(
      value: viewModel.isColumnSelected(column),
      title: Text(column.$name),
      onChanged: (value) => viewModel.onColumnConfirmed(column, value),
    );
  }
}
