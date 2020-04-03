import 'package:flutter/material.dart';

class StyledSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  StyledSwitch({
    @required this.value,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).accentColor,
      );
}
