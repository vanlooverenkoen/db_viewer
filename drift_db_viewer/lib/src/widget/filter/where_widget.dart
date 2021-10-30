import 'package:db_viewer/src/model/filter/where/where_clause.dart';
import 'package:db_viewer/src/style/theme_dimens.dart';
import 'package:flutter/material.dart';
import 'package:drift_db_viewer/src/model/filter/where/blob_where_clause.dart';
import 'package:drift_db_viewer/src/model/filter/where/bool_where_clause.dart';
import 'package:drift_db_viewer/src/model/filter/where/date_where_clause.dart';
import 'package:drift_db_viewer/src/model/filter/where/double_where_clause.dart';
import 'package:drift_db_viewer/src/model/filter/where/int_where_clause.dart';
import 'package:drift_db_viewer/src/model/filter/where/string_where_clause.dart';
import 'package:drift_db_viewer/src/widget/filter/where/where_blob_widget.dart';
import 'package:drift_db_viewer/src/widget/filter/where/where_bool_widget.dart';
import 'package:drift_db_viewer/src/widget/filter/where/where_date_widget.dart';
import 'package:drift_db_viewer/src/widget/filter/where/where_double_widget.dart';
import 'package:drift_db_viewer/src/widget/filter/where/where_int_widget.dart';
import 'package:drift_db_viewer/src/widget/filter/where/where_string_widget.dart';

class WhereTitleWidget extends StatelessWidget {
  final VoidCallback onAddClicked;
  final List<WhereClause> whereClauses;

  const WhereTitleWidget({
    required this.onAddClicked,
    required this.whereClauses,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeDimens.padding16,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'WHERE',
                  style: theme.textTheme.bodyText1,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: onAddClicked,
              ),
            ],
          ),
        ),
        for (final item in whereClauses) ...{
          if (item is DateWhereClause) WhereDateWidget(whereClause: item),
          if (item is IntWhereClause) WhereIntWidget(whereClause: item),
          if (item is BoolWhereClause) WhereBoolWidget(whereClause: item),
          if (item is StringWhereClause) WhereStringWidget(whereClause: item),
          if (item is DoubleWhereClause) WhereDoubleWidget(whereClause: item),
          if (item is BlobWhereClause) WhereBlobWidget(whereClause: item),
        },
      ],
    );
  }
}
