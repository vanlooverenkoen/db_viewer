import 'package:db_viewer/src/style/theme_dimens.dart';
import 'package:db_viewer/src/style/theme_durations.dart';
import 'package:flutter/material.dart';

class SelectableAction extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback? onClick;

  const SelectableAction({
    required this.text,
    required this.selected,
    this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.secondary;
    final textColor = theme.scaffoldBackgroundColor;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeDimens.padding4,
        vertical: ThemeDimens.padding2,
      ),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ThemeDimens.padding32),
          border: Border.all(
            color: accentColor,
          ),
          color: selected ? accentColor : textColor,
        ),
        duration: ThemeDurations.shortAnimationDuration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(ThemeDimens.padding32),
            onTap: onClick,
            child: AnimatedDefaultTextStyle(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: ThemeDimens.padding24,
                  vertical: ThemeDimens.padding8,
                ),
                child: Text(text),
              ),
              duration: ThemeDurations.shortAnimationDuration(),
              style: selected
                  ? TextStyle(color: textColor)
                  : TextStyle(color: accentColor),
            ),
          ),
        ),
      ),
    );
  }
}
