import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/style/theme_colors.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/style/theme_text_styles.dart';

class InputLikeText extends StatelessWidget {
  final VoidCallback onClick;
  final String text;

  const InputLikeText({
    @required this.onClick,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(ThemeDimens.radius),
            topLeft: Radius.circular(ThemeDimens.radius),
          ),
          color: ThemeColors.filledGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ThemeDimens.padding12,
                vertical: ThemeDimens.padding16,
              ),
              child: Text(
                text,
                style: ThemeTextStyles.dateSelectorItem,
              ),
            ),
            Container(
              height: 1,
              color: ThemeColors.mediumGrey,
            ),
          ],
        ),
      ),
    );
  }
}
