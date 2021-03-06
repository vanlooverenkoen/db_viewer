import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/style/theme_colors.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';

class SelectQueryWidget extends StatelessWidget {
  final String query;
  final VoidCallback onEditClicked;

  const SelectQueryWidget({
    required this.query,
    required this.onEditClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEditClicked,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            color: ThemeColors.lightGrey,
            padding: EdgeInsets.all(ThemeDimens.padding16),
            child: Text(query),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              Icons.edit,
              size: ThemeDimens.padding16,
            ),
          ),
        ],
      ),
    );
  }
}
