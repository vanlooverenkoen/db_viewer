import 'package:flutter/material.dart';

class TableRowItem extends StatelessWidget {
  final String tableName;
  final VoidCallback onClick;

  const TableRowItem({
    required this.tableName,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          tableName,
          style: theme.textTheme.button,
        ),
      ),
      onTap: onClick,
    );
  }
}
