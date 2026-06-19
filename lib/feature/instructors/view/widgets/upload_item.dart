import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../viewmodel/materials_viewmodel.dart';

class UploadItem extends StatelessWidget {
  final File file;
  final VoidCallback onDelete;
  UploadItem({super.key, required this.onDelete, required this.file});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryLight.withOpacity(.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.path.split('/').last,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "PDF • ${(file.lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB",
                  style: textTheme.bodySmall?.copyWith(
                    color: AppTheme.hintText,
                  ),
                ),
              ],
            ),
          ),
          IconButton(onPressed: onDelete, icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}
