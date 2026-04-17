import 'package:flutter/material.dart';
import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';

class UploadMaterialSheet extends StatelessWidget {
  UploadMaterialSheet({super.key});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upload Material",
                style: textTheme.headlineSmall,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.backgroundLight,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              )
            ],
          ),

          const SizedBox(height: 20),

          /// MATERIAL NAME
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "MATERIAL NAME",
              style: textTheme.titleSmall!
                  .copyWith(color: AppTheme.secondText),
            ),
          ),

          const SizedBox(height: 8),

          DefaultTextField(
            hint: "e.g. Midterm Study Guide",
            prefixIcon: Icon(Icons.description_outlined),
            controller: nameController,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "SELECT FILE",
              style: textTheme.titleSmall!
                  .copyWith(color: AppTheme.secondText),
            ),
          ),

          const SizedBox(height: 10),

          /// FILE PICKER AREA
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppTheme.backgroundLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cloud_upload,
                    color: AppTheme.primaryLight,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Tap to choose a file",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  "PDF, DOCX, PPT or ZIP up to 25MB",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.secondText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// BUTTONS
          Row(
            children: [

              /// CANCEL
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              /// UPLOAD
              Expanded(
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "Upload Material",
                    style: TextStyle(
                      color: AppTheme.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}