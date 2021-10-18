import 'package:db_viewer/src/widget/general/expandable_filter_item/expandable_where_item.dart';
import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/where/blob_where_clause.dart';
import 'package:moor_db_viewer/src/viewmodel/filter/moor_table_filter_viewmodel.dart';
import 'package:provider/provider.dart';

class WhereBlobWidget extends StatelessWidget {
  final BlobWhereClause whereClause;

  const WhereBlobWidget({
    required this.whereClause,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpandableWhereItem(
      whereClause: whereClause,
      onDismissed: () => Provider.of<MoorTableFilterViewModel>(context, listen: false).onDismissWhereClause(whereClause),
      children: [
        Text(
          'Filtering on a blob is not supported',
          style: theme.textTheme.bodyText1,
        ),
      ],
    );
  }
}
