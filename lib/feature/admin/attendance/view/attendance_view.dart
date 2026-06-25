import 'package:edusync_app/core/widgets/back_item.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../users/data/remote/users_remote_data_source_impl.dart';
import '../../../users/repository/users_repository_impl.dart';
import '../../instructors/data/remote/instructor_subject_remote_data_source_impl.dart';
import '../../instructors/data/remote/subject_remote_data_source_impl.dart';
import '../../instructors/repository/instructor_repository.dart';
import '../../instructors/repository/instructor_subject_repository_impl.dart';
import '../../instructors/repository/subject_repository_impl.dart';
import '../../instructors/viewmodel/instructor_viewmodel.dart';
import '../data/remote/attendance_remote_data_source_impl.dart';
import '../repository/attendance_repository_impl.dart';
import '../view_model/attendance_view_model.dart';
import '../widgets/attendance_table.dart';
import 'add_attendance_view.dart';

class AttendanceView extends StatelessWidget {
  static const String routeName = '/attendance';

  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<AttendanceViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(title: 'Attendance'),
        centerTitle: true,
        leading: BackItem(),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DefaultTextField(
                    hint: 'Search by Date or Instructor or Subject',
                    onChanged: (value) {
                      viewModel.searchAttendance(value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PrimaryButton(
                    label: 'Add',
                    onPressed: () async {
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
                              ChangeNotifierProvider(
                                create: (_) => AttendanceViewModel(
                                  AttendanceRepositoryImpl(
                                    AttendanceRemoteDataSourceImpl(),
                                  ),
                                ),
                              ),
                            ],
                            child: const AddAttendanceView(),
                          ),
                        ),
                      );
                      if (!context.mounted) return;
                      if (result == true) {
                        context.read<AttendanceViewModel>().loadAttendances();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AttendanceTable(),
          ],
        ),
      ),
    );
  }
}
