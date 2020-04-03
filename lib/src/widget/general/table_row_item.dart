import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;

class TableRowItem extends StatelessWidget {
  final TableInfo<moor.Table, DataClass> table;
  final VoidCallback onClick;

  const TableRowItem({
    @required this.table,
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(table.entityName),
      ),
      onTap: onClick,
    );
  }
}
