import 'package:db_viewer/db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:drift_db_viewer/src/model/filter/where/blob_where_clause.dart';
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
      onDismissed: () =>
          Provider.of<TableFilterViewModel>(context, listen: false)
              .onDismissWhereClause(whereClause),
      children: [
        Text(
          'Filtering on a blob is not supported',
          style: theme.textTheme.bodyText1,
        ),
      ],
    );
  }
}
