import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/style/theme_colors.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';

class SelectQueryWidget extends StatelessWidget {
  final String query;

  const SelectQueryWidget({
    @required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.lightGrey,
      padding: EdgeInsets.all(ThemeDimens.padding16),
      child: Text(query),
    );
  }
}
