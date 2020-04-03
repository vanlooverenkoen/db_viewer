import 'package:flutter/material.dart';

class StyledCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  StyledCheckBox({
    @required this.value,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).accentColor,
      );
}
