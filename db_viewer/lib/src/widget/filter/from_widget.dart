import 'package:db_viewer/src/style/theme_dimens.dart';
import 'package:db_viewer/src/widget/filter/selectable_action.dart';
import 'package:flutter/material.dart';

class FromWidget extends StatelessWidget {
  final String tableName;

  const FromWidget({
    required this.tableName,
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
            'FROM',
            style: theme.textTheme.bodyText1,
          ),
        ),
        SelectableAction(text: tableName, selected: true),
      ],
    );
  }
}
