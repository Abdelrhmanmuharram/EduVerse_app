import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackItem extends StatelessWidget {
  const BackItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: SvgPicture.asset(
        'assets/icons/back.svg',
        width: 24,
        height: 24,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
