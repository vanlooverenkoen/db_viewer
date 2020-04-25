import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/widget/filter/selectable_action.dart';

class AscDescWidget extends StatelessWidget {
  final bool asc;
  final VoidCallback onDescClicked;
  final VoidCallback onAscClicked;

  AscDescWidget({
    @required this.asc,
    @required this.onAscClicked,
    @required this.onDescClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeDimens.padding16,
            vertical: ThemeDimens.padding8,
          ),
          child: Text('ASC / DESC'),
        ),
        Wrap(
          children: [
            SelectableAction(
              text: 'ASC',
              selected: asc,
              onClick: onAscClicked,
            ),
            SelectableAction(
              text: 'DESC',
              selected: !asc,
              onClick: onDescClicked,
            )
          ],
        ),
      ],
    );
  }
}
