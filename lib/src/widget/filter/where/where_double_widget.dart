import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/where/double_where_clause.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/general/expandable_filter_item/expandable_where_item.dart';
import 'package:moor_db_viewer/src/widget/general/styled/styled_text_field.dart';
import 'package:provider/provider.dart';

class WhereDoubleWidget extends StatelessWidget {
  final DoubleWhereClause whereClause;

  const WhereDoubleWidget({
    @required this.whereClause,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableWhereItem(
      whereClause: whereClause,
      children: [
        RadioListTile<DoubleWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: DoubleWhereType.EQUALS,
          title: Text('Equals'),
        ),
        RadioListTile<DoubleWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: DoubleWhereType.CONTAINS,
          title: Text('Contains'),
        ),
        RadioListTile<DoubleWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: DoubleWhereType.GREATER_THAN,
          title: Text('Greater than'),
        ),
        RadioListTile<DoubleWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.intWhereType,
          value: DoubleWhereType.LESS_THAN,
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

  void _onChangedType(BuildContext context, DoubleWhereType value) {
    whereClause.onSelectedType(value);
    Provider.of<MoorTableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }
}
