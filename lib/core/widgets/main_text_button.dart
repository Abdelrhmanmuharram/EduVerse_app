import 'package:flutter/material.dart';

class MainTextButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  Color? color;

  MainTextButton({required this.onPressed, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: textTheme.titleMedium!.copyWith(color: color)),
    );
  }
}
