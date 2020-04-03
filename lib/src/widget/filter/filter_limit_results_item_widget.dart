import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_limit_results_item.dart';
import 'package:moor_db_viewer/src/style/theme_colors.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/items/filter_limit_results_viewmodel.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/viewmodel/global_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/general/single_filter_item.dart';
import 'package:moor_db_viewer/src/widget/general/styled/styled_text_field.dart';
import 'package:moor_db_viewer/src/widget/provider/provider_widget.dart';
import 'package:provider/provider.dart';

class FilterLimitResultsItemWidget extends StatelessWidget {
  final FilterLimitResultsItem filterItem;

  FilterLimitResultsItemWidget({@required this.filterItem});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FilterLimitResultsViewModel>(
      consumer: (context, viewModel, child) => Container(
        color: ThemeColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleFilterItemWidget(
              title: Text(
                'Limit the amount of results',
                style: TextStyle(fontSize: 16),
              ),
              subTitle: Text(
                'A high number will result in bad performance\n(thanks flutter datatabel)',
                style: TextStyle(fontSize: 11),
              ),
              trailing: Container(
                width: 100,
                child: StyledTextField(
                  controller: viewModel.controller,
                  inputType: TextInputType.number,
                  onChanged: viewModel.onLimitChanged,
                ),
              ),
            ),
          ],
        ),
      ),
      create: () => FilterLimitResultsViewModel(
        Provider.of<GlobalViewModel>(context).db,
        Provider.of<MoorTableFilterViewModel>(context).table,
        filterItem,
      ),
    );
  }
}
