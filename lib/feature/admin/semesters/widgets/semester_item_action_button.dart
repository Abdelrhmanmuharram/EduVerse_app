import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';

class SemesterItemActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  const SemesterItemActionButton({super.key, required this.icon,required this.onTap,this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color ?? AppTheme.blueGray.withAlpha(60)),
        ),
        child: Icon(icon, color: color ?? AppTheme.primaryLight),
      ),
    );
  }
}
