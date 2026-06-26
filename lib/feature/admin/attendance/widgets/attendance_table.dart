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
import '../view/edit_attendance_session_view.dart';
import '../view_model/attendance_view_model.dart';

class AttendanceTable extends StatelessWidget {
  const AttendanceTable({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<AttendanceViewModel>();
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: RefreshIndicator(
          color: AppTheme.white,
          backgroundColor: AppTheme.primaryLight,
          onRefresh: () async {
            await viewModel.loadAttendances();
          },
          child: viewModel.isLoading
              ? const Center(child: LoadingWidget())
              : ListView(
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
                          DataColumn(label: const Text("Date")),
                          const DataColumn(label: Text("Instructor")),
                          const DataColumn(label: Text("Subject")),
                          const DataColumn(label: Text("Action")),
                        ],
                        rows: viewModel.filteredAttendances.map((attendance) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  attendance.sessionDate
                                      .toString()
                                      .split(' ')
                                      .first,
                                ),
                              ),
                              DataCell(Text(attendance.instructorName)),
                              DataCell(Text(attendance.subjectName)),
                              DataCell(
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => MultiProvider(
                                              providers: [
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
                                                ChangeNotifierProvider.value(
                                                  value: context
                                                      .read<
                                                        AttendanceViewModel
                                                      >(),
                                                ),
                                              ],
                                              child: EditAttendanceSessionView(
                                                session: attendance,
                                              ),
                                            ),
                                          ),
                                        );
                                        if (!context.mounted) return;
                                        if (result == true) {
                                          await context
                                              .read<AttendanceViewModel>()
                                              .loadAttendances();
                                        }
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: AppTheme.primaryLight,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      child: Icon(
                                        Icons.person_pin_outlined,
                                        color: AppTheme.primaryLight,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    viewModel.deletingId == attendance.id
                                        ? const SizedBox(
                                            height: 16,
                                            width: 16,
                                            child: CircularProgressIndicator(
                                              color: AppTheme.primaryLight,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              final confirm = showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  title: const Text(
                                                    'Delete Attendance',
                                                  ),
                                                  content: const Text(
                                                    'Are you sure you want to delete this attendance?',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Cancel',
                                                        style: textTheme
                                                            .titleSmall,
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        final result =
                                                            await viewModel
                                                                .deleteAttendanceSession(
                                                                  attendance.id,
                                                                );
                                                        if (!context.mounted)
                                                          return;
                                                        if (!result) {
                                                          ScaffoldMessenger.of(
                                                            context,
                                                          ).showSnackBar(
                                                            SnackBar(
                                                              backgroundColor:
                                                                  AppTheme.red,
                                                              content: Text(
                                                                viewModel
                                                                    .errorMages,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Delete',
                                                        style: textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                              color:
                                                                  AppTheme.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                              if (confirm != true) return;
                                              await context
                                                  .read<AttendanceViewModel>()
                                                  .deleteAttendanceSession(
                                                    attendance.id,
                                                  );
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  backgroundColor:
                                                      AppTheme.green,
                                                  content: Text(
                                                    'Attendance deleted',
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: AppTheme.red,
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
