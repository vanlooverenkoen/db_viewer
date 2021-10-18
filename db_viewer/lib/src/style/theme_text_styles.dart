import 'package:db_viewer/src/style/theme_colors.dart';
import 'package:flutter/material.dart';

class ThemeTextStyles {
  ThemeTextStyles._();

  static const textActionItemDisabled = TextStyle(
      color: ThemeColors.lightGrey, fontSize: 14, fontWeight: FontWeight.bold);
  static const textActionItemEnabled = TextStyle(
      color: ThemeColors.black, fontSize: 14, fontWeight: FontWeight.bold);

  static const expandableFilterTitleOpen = TextStyle(
      color: ThemeColors.black, fontSize: 14, fontWeight: FontWeight.bold);
  static const expandableFilterTitleClose = TextStyle(
      color: ThemeColors.black, fontSize: 14, fontWeight: FontWeight.bold);

  static const expandedFilterItem = TextStyle(
      color: ThemeColors.grey, fontSize: 14, fontWeight: FontWeight.w300);

  static const expandedFilterIndicatorOpen = TextStyle(
      color: ThemeColors.mediumGrey, fontSize: 14, fontWeight: FontWeight.bold);
  static const expandedFilterIndicatorClose = TextStyle(
      color: ThemeColors.mediumGrey, fontSize: 14, fontWeight: FontWeight.w300);

  static const dateSelectorItem =
      TextStyle(color: ThemeColors.black, fontSize: 15);
}
