import 'package:db_viewer/src/style/theme_dimens.dart';
import 'package:db_viewer/src/widget/filter/selectable_action.dart';
import 'package:flutter/material.dart';

class OrderByWidget extends StatelessWidget {
  final Map<String, bool> columns;
  final ValueChanged<String> onToggleColumn;

  const OrderByWidget({
    required this.columns,
    required this.onToggleColumn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeDimens.padding16,
            vertical: ThemeDimens.padding8,
          ),
          child: Text(
            'ORDER BY',
            style: theme.textTheme.bodyText1,
          ),
        ),
        Wrap(
          children: [
            for (var i = 0; i < columns.keys.length; ++i)
              SelectableAction(
                selected: columns.values.toList()[i],
                text: columns.keys.toList()[i],
                onClick: () => onToggleColumn(columns.keys.toList()[i]),
              ),
          ],
        ),
      ],
    );
  }
}
