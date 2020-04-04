import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/filter_column_item.dart';
import 'package:moor_db_viewer/src/model/filter/filter_item.dart';
import 'package:moor_db_viewer/src/model/filter/filter_limit_results_item.dart';
import 'package:moor_db_viewer/src/model/filter/filter_search_item.dart';
import 'package:moor_db_viewer/src/widget/filter/filter_columns_item_widget.dart';
import 'package:moor_db_viewer/src/widget/filter/filter_limit_results_item_widget.dart';
import 'package:moor_db_viewer/src/widget/filter/filter_search_item_widget.dart';
import 'package:moor_db_viewer/src/widget/general/expandable_filter_item/expandable_filter_item.dart';

class FilterItemWidget extends StatelessWidget {
  final FilterItem filterItem;
  final VoidCallback onRemove;
  final ValueChanged<bool> onEnableFilterChanged;

  FilterItemWidget({
    @required this.filterItem,
    @required this.onRemove,
    @required this.onEnableFilterChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(filterItem),
      confirmDismiss: confirmDismiss,
      direction: DismissDirection.endToStart,
      onDismissed: _onDismissed,
      child: Card(
        child: ExpandableFilterItem(
          title: filterItem.name,
          enabled: filterItem.isEnabled,
          onEnabledChanged: onEnableFilterChanged,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (filterItem is FilterLimitResultsItem) {
                return FilterLimitResultsItemWidget(filterItem: filterItem);
              } else if (filterItem is FilterColumnsItem) {
                return FilterColumnsItemWidget(filterItem: filterItem);
              } else if (filterItem is FilterSearchItem) {
                return FilterSearchItemWidget(
                  filterItem: filterItem,
                );
              }
              throw ArgumentError(
                  'invalid filteritem ${filterItem.runtimeType}');
            },
          ),
        ),
      ),
    );
  }

  void _onDismissed(DismissDirection direction) => onRemove();

  Future<bool> confirmDismiss(DismissDirection direction) async =>
      filterItem.canBeDismissed;
}
