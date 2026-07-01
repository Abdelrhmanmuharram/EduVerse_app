import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/file_download_service.dart';
import '../../model/instructor_material_model.dart';
import '../../viewmodel/materials_viewmodel.dart';
import '../screens/material_add_view.dart';
import '../screens/materials_details_view.dart';
import '../screens/pdf_view.dart';

class MaterialItem extends StatelessWidget {
  final InstructorMaterialModel material;
  const MaterialItem({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final vm = context.read<MaterialsViewModel>();
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider.value(
              value: context.read<MaterialsViewModel>(),
              child: MaterialAddView(
                material: material,
              ),
            ),
          ),
        );
        if (result == true && context.mounted) {
          await context.read<MaterialsViewModel>().loadMaterials();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.hintText),
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PdfView(
                          url: material.filePath,
                          title: material.title,
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.picture_as_pdf_outlined,
                    color: AppTheme.red,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    FileDownloadService.downloadFile(
                      url: material.filePath,
                      fileName: material.title,
                    );
                  },
                  child: Icon(
                    Icons.download,
                    color: AppTheme.primaryLight,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Delete Material"),
                        content: const Text(
                          "Are you sure you want to delete this material?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: AppTheme.primaryLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: TextButton.styleFrom(
                              foregroundColor: AppTheme.red,
                            ),
                            child: const Text(
                              "Delete",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      try {
                        await vm.deleteMaterial(material.id);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "Material deleted successfully",
                            ),
                            backgroundColor: AppTheme.green,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: Icon(Icons.delete, color: AppTheme.red),
                ),
              ],
            ),
            Text(
              material.subjectName,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryLight,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              material.description ?? 'No description',
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
