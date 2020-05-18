import 'package:flutter/material.dart';
import 'package:moor_db_viewer/src/style/theme_colors.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final TextAlign textAlign;
  final TextInputType inputType;

  const StyledTextField({
    @required this.controller,
    @required this.onChanged,
    this.hint,
    this.textAlign = TextAlign.start,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: ThemeColors.filledGrey,
        hintText: hint ?? '',
      ),
      keyboardType: inputType,
      textAlign: textAlign,
      onChanged: onChanged,
      controller: controller,
    );
  }
}
