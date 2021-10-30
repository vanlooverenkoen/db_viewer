import 'package:flutter/material.dart';
import 'package:db_viewer/db_viewer.dart';
import 'package:drift_db_viewer/src/model/filter/where/double_where_clause.dart';
import 'package:provider/provider.dart';

class WhereDoubleWidget extends StatelessWidget {
  final DoubleWhereClause whereClause;

  const WhereDoubleWidget({
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
        RadioListTile<DoubleWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: DoubleWhereType.EQUALS,
          title: Text(
            'Equals',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<DoubleWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: DoubleWhereType.CONTAINS,
          title: Text(
            'Contains',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<DoubleWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: DoubleWhereType.GREATER_THAN,
          title: Text(
            'Greater than',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<DoubleWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: DoubleWhereType.LESS_THAN,
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

  void _onChangedType(BuildContext context, DoubleWhereType? value) {
    if (value == null) return;
    whereClause.onSelectedType(value);
    Provider.of<TableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }
}
