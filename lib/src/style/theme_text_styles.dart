import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/style/theme_colors.dart';

class ThemeTextStyles {
  ThemeTextStyles._();

  static const itemDetailTitle = TextStyle(
      color: ThemeColors.mediumGrey, fontSize: 14, fontWeight: FontWeight.bold);
  static const itemDetailContent = TextStyle(
      color: ThemeColors.mediumGrey,
      fontSize: 14,
      fontWeight: FontWeight.normal);

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
