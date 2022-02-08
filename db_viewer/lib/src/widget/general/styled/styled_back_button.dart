import 'package:flutter/material.dart';

class StyledBackButton extends StatelessWidget {
  final VoidCallback onBackClicked;

  const StyledBackButton({
    required this.onBackClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final targetPlatform = Theme.of(context).platform;
    return IconButton(
      icon: Icon(
        targetPlatform == TargetPlatform.android
            ? Icons.arrow_back
            : Icons.arrow_back_ios,
      ),
      onPressed: onBackClicked,
    );
  }
}
