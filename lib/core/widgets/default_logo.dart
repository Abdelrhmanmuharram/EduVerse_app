import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class DefaultLogo extends StatelessWidget {
  final double size;

  const DefaultLogo({super.key, this.size = 72});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/ev.png',
      width: size,
      height: size,
    );
  }
}
