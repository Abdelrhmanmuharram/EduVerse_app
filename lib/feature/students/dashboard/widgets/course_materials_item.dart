import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/services/file_download_service.dart';
import '../view/student_pdf_view.dart';
import '../view_model/student_subject_details_view_model.dart';

class CourseMaterialsItem extends StatelessWidget {
  const CourseMaterialsItem({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final vm = context.watch<StudentSubjectDetailsViewModel>();
    return SizedBox(
      height: vm.materials.length == 1 ? 100 : 220,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: vm.materials.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, index) {
          final material = vm.materials[index];
          return InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StudentPdfView(
                    title: material.title,
                    pdfUrl: material.filePath,
                    fileName: material.publicId,
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppTheme.hintText,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.red.withAlpha(40),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.picture_as_pdf,
                        color: AppTheme.red,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            material.title,
                            style: textTheme.headlineSmall,
                          ),
                          Text(
                            'Dr. ${material.instructorName}',
                            style: textTheme.titleSmall!.copyWith(
                              color: AppTheme.secondText,
                            ),
                          ),
                          if (material.description != null &&
                              material.description!.isNotEmpty)
                            Text(
                              material.description!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall,
                            ),
                        ],
                      )
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await FileDownloadService.downloadFile(
                            url: material.filePath,
                            fileName: material.publicId,
                          );
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Downloaded Successfully'),
                            ),
                          );
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.file_download,
                        color: AppTheme.primaryLight,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
