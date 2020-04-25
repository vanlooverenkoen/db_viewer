import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/model/filter/where/blob_where_clause.dart';
import 'package:moor_db_viewer/src/widget/general/expandable_filter_item/expandable_where_item.dart';

class WhereBlobWidget extends StatelessWidget {
  final BlobWhereClause whereClause;

  const WhereBlobWidget({
    @required this.whereClause,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableWhereItem(
      whereClause: whereClause,
      children: [
        Text('Filtering on a blob is not supported'),
      ],
    );
  }
}
