import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/where/where_clause.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/general/expandable_filter_item/expandable_filter_item.dart';
import 'package:provider/provider.dart';

class ExpandableWhereItem extends StatelessWidget {
  final List<Widget> children;
  final WhereClause whereClause;

  const ExpandableWhereItem({
    required this.children,
    required this.whereClause,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: ValueKey(whereClause.id),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart ||
            direction == DismissDirection.startToEnd) {
          Provider.of<MoorTableFilterViewModel>(context, listen: false)
              .onDismissWhereClause(whereClause);
        }
      },
      child: Card(
        child: ExpandableFilterItem(
          title: whereClause.columnName,
          subtitle: '(${whereClause.typeName})',
          backgroundColor: theme.cardColor,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              bottom: ThemeDimens.padding8,
              right: ThemeDimens.padding16,
              left: ThemeDimens.padding16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
