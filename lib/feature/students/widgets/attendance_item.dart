import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_theme.dart';

class AttendanceItem extends StatelessWidget {
  const AttendanceItem({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 110,
      child: Row(
        mainAxisAlignment: .center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.12,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppTheme.primaryLight, width: 2),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/att.svg',
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
                color: AppTheme.primaryLight,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.hintText.withAlpha(40),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Monday, Oct 16',
                  style: textTheme.titleLarge!.copyWith(
                    color: AppTheme.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '09:00 AM',
                  style: textTheme.titleSmall!.copyWith(
                    color: AppTheme.secondText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.green.withAlpha(40),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Present',
                    textAlign: TextAlign.center,
                    style: textTheme.titleSmall!.copyWith(
                      color: AppTheme.green,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
