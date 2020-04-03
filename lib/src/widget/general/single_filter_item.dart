import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';

class SingleFilterItemWidget extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subTitle;
  final Widget trailing;

  SingleFilterItemWidget({
    @required this.title,
    this.leading,
    this.subTitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(
          left: ThemeDimens.padding24,
          right: ThemeDimens.padding16,
          bottom: ThemeDimens.padding8,
          top: ThemeDimens.padding8,
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading,
              Container(width: ThemeDimens.padding16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  title,
                  if (subTitle != null) ...[
                    Container(
                      height: ThemeDimens.padding4,
                    ),
                    subTitle,
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              Container(width: ThemeDimens.padding8),
              trailing,
            ],
          ],
        ),
      ),
    );
  }
}
