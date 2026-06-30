import 'package:flutter/material.dart';

import '../../../core/app_theme.dart';

class CourseMaterialsItem extends StatelessWidget {
  const CourseMaterialsItem({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.hintText, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.red.withAlpha(40),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.picture_as_pdf_outlined,
                    color: AppTheme.red,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text('Mathematics', style: textTheme.headlineSmall),
                    Text(
                      'Oct 24, 2024 - 4.2 MB',
                      style: textTheme.titleSmall!.copyWith(
                        color: AppTheme.secondText,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.file_download,
                  color: AppTheme.primaryLight,
                  size: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
