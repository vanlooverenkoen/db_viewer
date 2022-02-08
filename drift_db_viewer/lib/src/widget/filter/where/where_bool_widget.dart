import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:drift_db_viewer/src/model/filter/where/bool_where_clause.dart';
import 'package:provider/provider.dart';

class WhereBoolWidget extends StatelessWidget {
  final BoolWhereClause whereClause;

  const WhereBoolWidget({
    required this.whereClause,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpandableWhereItem(
      whereClause: whereClause,
      onDismissed: () =>
          Provider.of<TableFilterViewModel>(context, listen: false)
              .onDismissWhereClause(whereClause),
      children: [
        RadioListTile<bool>(
          onChanged: (value) => _onChanged(context, value),
          groupValue: whereClause.value,
          value: true,
          title: Text(
            'True',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<bool>(
          onChanged: (value) => _onChanged(context, value),
          groupValue: whereClause.value,
          value: false,
          title: Text(
            'False',
            style: theme.textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  void _onChanged(BuildContext context, bool? value) {
    if (value == null) return;
    whereClause.onSelectedChanged(value);
    Provider.of<TableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }
}
