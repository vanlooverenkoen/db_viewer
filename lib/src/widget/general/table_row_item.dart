import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:moor/moor.dart' as moor;

class TableRowItem extends StatelessWidget {
  final TableInfo<moor.Table, dynamic> table;
  final VoidCallback onClick;

  const TableRowItem({
    required this.table,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          table.entityName,
          style: theme.textTheme.button,
        ),
      ),
      onTap: onClick,
    );
  }
}
