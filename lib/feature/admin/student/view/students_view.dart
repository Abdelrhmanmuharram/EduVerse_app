import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:edusync_app/feature/admin/student/view/add_student_view.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/feature/admin/student/model/student_model.dart';
import 'package:edusync_app/feature/admin/student/view/student_details_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../departments/model/department_model.dart';
import '../../departments/viewmodel/departement_viewmodel.dart';
import '../../../years/model/year_model.dart';
import '../../../years/viewmodel/year_viewmodel.dart';
import '../model/add_student_model.dart';
import '../viewmodel/student_viewmodel.dart';
import '../widgets/student_header.dart';
import '../widgets/student_table.dart';

class StudentsView extends StatefulWidget {
  static const String routeName = '/students';
  const StudentsView({super.key});

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  void onRowTap(AddStudentModel student) {
    Navigator.pushNamed(
      context,
      StudentDetailsView.routeName,
      arguments: student,
    );
  }

  @override
  Widget build(BuildContext context) {
    final departmentName = context.watch<DepartmentViewModel>();
    final yearVm = context.watch<YearViewmodel>();
    final viewModel = Provider.of<StudentViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 20),
                StudentHeader(),
                SizedBox(height: 24),
                DefaultTextField(
                  hint: 'Search by name, code, or dept...',
                  prefixIcon: Icon(Icons.search),
                  onChanged: viewModel.search,
                ),
                SizedBox(height: 12),
                viewModel.isLoading
                    ? LoadingWidget()
                    : viewModel.isEmpty
                    ? Center(child: Text('No students found'))
                    : RefreshIndicator(
                        color: Colors.blue,
                        onRefresh: () async {
                          await viewModel.loadStudents();
                        },
                        child: StudentTable(
                          students: viewModel.getTableStudents(
                            departmentName.departments,
                            yearVm.years,
                          ),
                          onRowTap: (student) async {
                            final user = viewModel.students.firstWhere(
                              (u) => u.id == student.id,
                            );
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MultiProvider(
                                  providers: [
                                    ChangeNotifierProvider.value(
                                      value: context.read<StudentViewModel>(),
                                    ),
                                    ChangeNotifierProvider.value(
                                      value: context
                                          .read<DepartmentViewModel>(),
                                    ),
                                    ChangeNotifierProvider.value(
                                      value: context.read<YearViewmodel>(),
                                    ),
                                  ],
                                  child: const StudentDetailsView(),
                                ),
                                settings: RouteSettings(
                                  arguments: {
                                    'user': user,
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 48,
        width: 48,
        child: Transform.translate(
          offset: Offset(-5, 20),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddStudentView.routeName);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
