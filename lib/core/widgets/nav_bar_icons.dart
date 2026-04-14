import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarIcons extends StatelessWidget {
  String iconName;

  NavBarIcons({required this.iconName});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      height: 24,
      width: 24,
      fit: .scaleDown,
    );
  }
}
