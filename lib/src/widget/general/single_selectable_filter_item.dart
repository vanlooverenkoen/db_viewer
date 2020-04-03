import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/style/theme_dimens.dart';
import 'package:moor_db_viewer/src/widget/general/single_filter_item.dart';
import 'package:moor_db_viewer/src/widget/general/styled/styled_checkbox.dart';

class SingleSelectableFilterItem extends StatelessWidget {
  final Widget title;
  final Widget subTitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool checkbox;

  SingleSelectableFilterItem.checkbox({
    @required this.title,
    @required this.value,
    @required this.onChanged,
    this.subTitle,
  }) : checkbox = true;

  SingleSelectableFilterItem.checkmark({
    @required this.title,
    @required this.value,
    @required this.onChanged,
    this.subTitle,
  }) : checkbox = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: SingleFilterItemWidget(
        title: title,
        subTitle: subTitle,
        trailing: checkbox
            ? StyledCheckBox(
                value: value,
                onChanged: onChanged,
              )
            : value
                ? Icon(
                    Icons.check,
                    size: ThemeDimens.padding24,
                    color: Theme.of(context).accentColor,
                  )
                : Container(
                    height: ThemeDimens.padding24,
                    width: ThemeDimens.padding24,
                  ),
      ),
    );
  }
}
