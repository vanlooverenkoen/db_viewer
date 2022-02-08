import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  final String text;

  const ErrorTextWidget({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        text,
        style: theme.textTheme.bodyText1,
      ),
    );
  }
}
