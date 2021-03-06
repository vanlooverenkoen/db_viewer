import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/where/int_where_clause.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/general/expandable_filter_item/expandable_where_item.dart';
import 'package:moor_db_viewer/src/widget/general/styled/styled_text_field.dart';
import 'package:provider/provider.dart';

class WhereIntWidget extends StatelessWidget {
  final IntWhereClause whereClause;

  const WhereIntWidget({
    required this.whereClause,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableWhereItem(
      whereClause: whereClause,
      children: [
        RadioListTile<IntWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: IntWhereType.EQUALS,
          title: Text('Equals'),
        ),
        RadioListTile<IntWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: IntWhereType.CONTAINS,
          title: Text('Contains'),
        ),
        RadioListTile<IntWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: IntWhereType.GREATER_THAN,
          title: Text('Greater than'),
        ),
        RadioListTile<IntWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: IntWhereType.LESS_THAN,
          title: Text('Less than'),
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
    Provider.of<MoorTableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }

  void _onChangedType(BuildContext context, IntWhereType? value) {
    if (value == null) return;
    whereClause.onSelectedType(value);
    Provider.of<MoorTableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }
}
