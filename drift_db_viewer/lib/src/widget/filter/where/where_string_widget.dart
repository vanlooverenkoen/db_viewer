import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:drift_db_viewer/src/model/filter/where/string_where_clause.dart';
import 'package:provider/provider.dart';

class WhereStringWidget extends StatelessWidget {
  final StringWhereClause whereClause;

  const WhereStringWidget({
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
        RadioListTile<StringWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.stringWhereType,
          value: StringWhereType.CONTAINS,
          title: Text(
            'Contains',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<StringWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.stringWhereType,
          value: StringWhereType.EQUALS,
          title: Text(
            'Equals',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<StringWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.stringWhereType,
          value: StringWhereType.NOT_CONTAINS,
          title: Text(
            'Not contains',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<StringWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.stringWhereType,
          value: StringWhereType.NOT_EQUALS,
          title: Text(
            'Not equals',
            style: theme.textTheme.bodyText1,
          ),
        ),
        Container(height: ThemeDimens.padding4),
        StyledTextField(
          hint: 'Enter your search query',
          onChanged: (value) => _onChange(context, value),
          controller: whereClause.textController,
        )
      ],
    );
  }

  void _onChange(BuildContext context, String value) {
    whereClause.updateQuery(value);
    Provider.of<TableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }

  void _onChangedType(BuildContext context, StringWhereType? value) {
    if (value == null) return;
    whereClause.onSelectedType(value);
    Provider.of<TableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }
}
