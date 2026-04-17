import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'material_item_card.dart';
import 'upload_material_sheet.dart';

class MaterialsSection extends StatelessWidget {
  final List materials;

  const MaterialsSection({
    super.key,
    required this.materials,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),

      child: Column(
        children: [

          /// 🔥 Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: const [
                  Icon(
                    Icons.folder_open,
                    color: AppTheme.primaryLight,
                  ),
                  SizedBox(width: 8),
                  Text("Materials"),
                ],
              ),

              /// Upload Button
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => UploadMaterialSheet(),
                  );
                },
                child: const Text(
                  "+ Upload",
                  style: TextStyle(
                    color: AppTheme.primaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// 🔥 Materials List
          Column(
            children: materials
                .map(
                  (e) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MaterialItemCard(material: e),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}