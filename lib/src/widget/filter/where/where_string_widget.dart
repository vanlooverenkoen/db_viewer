import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/where/string_where_clause.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/general/expandable_filter_item/expandable_where_item.dart';
import 'package:moor_db_viewer/src/widget/general/styled/styled_text_field.dart';
import 'package:provider/provider.dart';

class WhereStringWidget extends StatelessWidget {
  final StringWhereClause whereClause;

  const WhereStringWidget({
    @required this.whereClause,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableWhereItem(
      whereClause: whereClause,
      children: [
        RadioListTile<StringWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.stringWhereType,
          value: StringWhereType.CONTAINS,
          title: Text('Contains'),
        ),
        RadioListTile<StringWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.stringWhereType,
          value: StringWhereType.EQUALS,
          title: Text('Equals'),
        ),
        RadioListTile<StringWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.stringWhereType,
          value: StringWhereType.NOT_CONTAINS,
          title: Text('Not contains'),
        ),
        RadioListTile<StringWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.stringWhereType,
          value: StringWhereType.NOT_EQUALS,
          title: Text('Not equals'),
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
    Provider.of<MoorTableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }

  void _onChangedType(BuildContext context, StringWhereType value) {
    whereClause.onSelectedType(value);
    Provider.of<MoorTableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }
}
