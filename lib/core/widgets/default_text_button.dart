import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  Color? color;

  DefaultTextButton({required this.onPressed, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: textTheme.titleMedium!.copyWith(color: color)),
    );
  }
}
