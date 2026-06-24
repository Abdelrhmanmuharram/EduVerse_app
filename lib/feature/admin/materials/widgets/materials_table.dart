import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../users/data/remote/users_remote_data_source_impl.dart';
import '../../../users/repository/users_repository_impl.dart';
import '../../instructors/data/remote/instructor_subject_remote_data_source_impl.dart';
import '../../instructors/data/remote/subject_remote_data_source_impl.dart';
import '../../instructors/repository/instructor_repository.dart';
import '../../instructors/repository/instructor_subject_repository_impl.dart';
import '../../instructors/repository/subject_repository_impl.dart';
import '../../instructors/viewmodel/instructor_viewmodel.dart';
import '../../subject/data/remote/subjects_remote_data_source_impl.dart';
import '../../subject/repository/subjects_repository_impl.dart';
import '../../subject/view_model/subject_view_model.dart';
import '../view/materials_admin_details_view.dart';
import '../view/pdf_viewer_screen.dart';
import '../view_model/materials_admin_view_model.dart';
import '../view_model/pdf_viewer_view_model.dart';

class MaterialsTable extends StatelessWidget {
  const MaterialsTable({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<MaterialAdminViewModel>();
    if (viewModel.isLoading) {
      return const Expanded(child: Center(child: LoadingWidget()));
    }
    if (viewModel.materials.isEmpty) {
      return const Expanded(child: Center(child: Text('No Materials Found')));
    }
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: RefreshIndicator(
          onRefresh: () => viewModel.loadMaterials(),
          backgroundColor: AppTheme.primaryLight,
          color: AppTheme.white,
          child: ListView(
            children: [
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  sortAscending: true,
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryLight,
                  ),
                  columns: [
                    DataColumn(label: const Text("Title")),
                    const DataColumn(label: Text("Subject")),
                    const DataColumn(label: Text("Instructor")),
                    const DataColumn(label: Text("File")),
                    const DataColumn(label: Text("Action")),
                  ],

                  rows: viewModel.materials.map((material) {
                    return DataRow(
                      cells: [
                        DataCell(Text(material.title)),
                        DataCell(Text(material.subject.engName)),
                        DataCell(Text(material.instructor.fullName)),
                        DataCell(
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ChangeNotifierProvider(
                                          create: (_) => PdfViewerViewModel(),
                                          child: PdfViewerScreen(
                                            pdfUrl: material.filePath,
                                            title: material.title,
                                            fileName: material.publicId,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.picture_as_pdf,
                                    color: AppTheme.red,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    final isSaved = await context
                                        .read<MaterialAdminViewModel>()
                                        .downloadPdf(
                                          material.filePath,
                                          material.publicId,
                                        );
                                    if (!context.mounted) return;
                                    if (isSaved) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: AppTheme.green,
                                          content: Text(
                                            'PDF downloaded successfully',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Icon(
                                    Icons.download,
                                    color: AppTheme.primaryLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MultiProvider(
                                          providers: [
                                            ChangeNotifierProvider.value(
                                              value: context.read<MaterialAdminViewModel>(),
                                            ),
                                            ChangeNotifierProvider(
                                              create: (_) => SubjectsViewModel(
                                                SubjectsRepositoryImpl(
                                                  SubjectsRemoteDataSourceImpl(),
                                                ),
                                              )..loadSubjects(),
                                            ),
                                            ChangeNotifierProvider(
                                              create: (_) => InstructorViewModel(
                                                UsersRepositoryImpl(
                                                  UsersRemoteDataSourceImpl(),
                                                ),
                                                InstructorRepository(),
                                                InstructorSubjectRepositoryImpl(
                                                  InstructorSubjectRemoteDataSourceImpl(),
                                                ),
                                                SubjectRepositoryImpl(
                                                  SubjectRemoteDataSourceImpl(),
                                                ),
                                              )..loadInstructors(),
                                            ),
                                          ],
                                          child: MaterialsAdminDetailsView(
                                            material: material,
                                          ),
                                        ),
                                      ),
                                    );
                                    if (result) {
                                      viewModel.loadMaterials();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: AppTheme.primaryLight,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Delete Material'),
                                          content: const Text(
                                            'Are you sure you want to delete this material?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: Text(
                                                'Cancel',
                                                style: textTheme.titleSmall,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: Text(
                                                'Delete',
                                                style: textTheme.titleSmall!
                                                    .copyWith(
                                                      color: AppTheme.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    if (confirm != true) return;
                                    final result = await viewModel
                                        .deleteMaterial(material.id);
                                    if (!context.mounted) return;
                                    if (result) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: AppTheme.green,
                                          content: Text(
                                            'Material deleted successfully',
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor: AppTheme.red,
                                          content: Text(
                                            viewModel.errorMessage ??
                                                'Failed to delete material',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: AppTheme.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
