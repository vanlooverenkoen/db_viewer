import 'package:db_viewer/src/model/filter/where/where_clause.dart';
import 'package:db_viewer/src/style/theme_dimens.dart';
import 'package:db_viewer/src/widget/general/expandable_filter_item/expandable_filter_item.dart';
import 'package:flutter/material.dart';

class ExpandableWhereItem extends StatelessWidget {
  final List<Widget> children;
  final WhereClause whereClause;
  final VoidCallback onDismissed;

  const ExpandableWhereItem({
    required this.children,
    required this.whereClause,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: ValueKey(whereClause.id),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart ||
            direction == DismissDirection.startToEnd) {
          onDismissed();
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
