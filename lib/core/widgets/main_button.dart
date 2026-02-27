import 'package:flutter/material.dart';

class MainBotton extends StatelessWidget {
  String text;
  VoidCallback onPressed;

  MainBotton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: textTheme.titleLarge),
    );
  }
}
