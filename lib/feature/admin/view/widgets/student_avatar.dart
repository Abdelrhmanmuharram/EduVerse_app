import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme.dart';

class StudentAvatar extends StatelessWidget {
  const StudentAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: .circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.black.withOpacity(0.2),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
            border: Border.all(color: AppTheme.white, width: 3),
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 40,
            width: 34,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppTheme.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.white, width: 3),
            ),
            child: SvgPicture.asset(
              'assets/icons/pencil.svg',
              width: 14,
              height: 20,
              fit: .scaleDown,
            ),
          ),
        ),
      ],
    );
  }
}
