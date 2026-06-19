import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/feature/instructors/model/materials_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/materials_details_view.dart';

class MaterialItem extends StatelessWidget {
  final MaterialsModel material;
   MaterialItem({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, MaterialsDetails.routeName),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.hintText,
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  material.title,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppTheme.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.picture_as_pdf_outlined,
                  color: AppTheme.red,
                  size: 28,
                ),
              ],
            ),
            Text(
              material.file.path,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryLight,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              material.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium?.copyWith(
                color: AppTheme.secondText,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
