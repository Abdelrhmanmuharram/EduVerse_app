import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarIcons extends StatelessWidget {
  final String iconName;

  const NavBarIcons({super.key, required this.iconName});

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
