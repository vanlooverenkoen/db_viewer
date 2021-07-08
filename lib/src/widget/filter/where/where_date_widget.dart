import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/where/date_where_clause.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/general/expandable_filter_item/expandable_where_item.dart';
import 'package:moor_db_viewer/src/widget/general/styled/input_like_text_field.dart';
import 'package:provider/provider.dart';

class WhereDateWidget extends StatelessWidget {
  final DateWhereClause whereClause;

  const WhereDateWidget({
    required this.whereClause,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpandableWhereItem(
      whereClause: whereClause,
      children: [
        RadioListTile<DateWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.dateWhereType,
          value: DateWhereType.BEFORE,
          title: Text(
            'Before',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<DateWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.dateWhereType,
          value: DateWhereType.EQUALS,
          title: Text(
            'Equals',
            style: theme.textTheme.bodyText1,
          ),
        ),
        RadioListTile<DateWhereType>(
          onChanged: (value) => _onChangedType(context, value),
          groupValue: whereClause.dateWhereType,
          value: DateWhereType.AFTER,
          title: Text(
            'After',
            style: theme.textTheme.bodyText1,
          ),
        ),
        InputLikeText(
          onClick: () => _onTapDate(context),
          text: whereClause.dateString,
        ),
        Container(height: ThemeDimens.padding8),
        InputLikeText(
          onClick: () => _onTapTime(context),
          text: whereClause.timeString,
        ),
      ],
    );
  }

  void _onChangedType(BuildContext context, DateWhereType? value) {
    if (value == null) return null;
    whereClause.onSelectedType(value);
    Provider.of<MoorTableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }

  Future<void> _onTapDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: whereClause.date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != whereClause.date) {
      whereClause.updateSelectedDate(picked);
      Provider.of<MoorTableFilterViewModel>(context, listen: false)
          .onUpdatedWhereClause();
    }
  }

  Future<void> _onTapTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: whereClause.time,
    );
    if (picked != null && picked != whereClause.time) {
      whereClause.updateSelectedTime(picked);
      Provider.of<MoorTableFilterViewModel>(context, listen: false)
          .onUpdatedWhereClause();
    }
  }
}
