import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:drift_db_viewer/src/model/filter/where/int_where_clause.dart';
import 'package:provider/provider.dart';

class WhereIntWidget extends StatelessWidget {
  final IntWhereClause whereClause;

  const WhereIntWidget({
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
        RadioListTile<IntWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: IntWhereType.EQUALS,
          title: Text(
            'Equals',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<IntWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: IntWhereType.CONTAINS,
          title: Text(
            'Contains',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<IntWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: IntWhereType.GREATER_THAN,
          title: Text(
            'Greater than',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<IntWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: IntWhereType.LESS_THAN,
          title: Text(
            'Less than',
            style: theme.textTheme.bodyText1,
          ),
        ),
        Container(height: ThemeDimens.padding4),
        StyledTextField(
          hint: 'Enter your search query',
          onChanged: (value) => _onChange(context, value),
          inputType: TextInputType.numberWithOptions(),
          controller: whereClause.textController,
        ),
      ],
    );
  }

  void _onChange(BuildContext context, String value) {
    whereClause.updateQuery(value);
    Provider.of<TableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }

  void _onChangedType(BuildContext context, IntWhereType? value) {
    if (value == null) return;
    whereClause.onSelectedType(value);
    Provider.of<TableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }
}
