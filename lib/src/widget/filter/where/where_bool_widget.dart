import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/where/bool_where_clause.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:moor_db_viewer/src/widget/general/expandable_filter_item/expandable_where_item.dart';
import 'package:provider/provider.dart';

class WhereBoolWidget extends StatelessWidget {
  final BoolWhereClause whereClause;

  const WhereBoolWidget({
    @required this.whereClause,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableWhereItem(
      whereClause: whereClause,
      children: [
        RadioListTile<bool>(
          onChanged: (value) => _onChanged(context, value),
          groupValue: whereClause.value,
          value: true,
          title: Text('True'),
        ),
        RadioListTile<bool>(
          onChanged: (value) => _onChanged(context, value),
          groupValue: whereClause.value,
          value: false,
          title: Text('False'),
        ),
      ],
    );
  }

  void _onChanged(BuildContext context, bool value) {
    whereClause.onSelectedChanged(value);
    Provider.of<MoorTableFilterViewModel>(context, listen: false)
        .onUpdatedWhereClause();
  }
}
