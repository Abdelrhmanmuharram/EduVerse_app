import 'package:edusync_app/core/widgets/back_item.dart';
import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:edusync_app/feature/admin/student/view/student_details_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../departments/viewmodel/departement_viewmodel.dart';
import '../../../years/viewmodel/year_viewmodel.dart';
import '../model/add_student_model.dart';
import '../viewmodel/student_viewmodel.dart';
import '../widgets/student_table.dart';
import 'add_student_view.dart';

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
    TextTheme textTheme = Theme.of(context).textTheme;
    final departmentName = context.watch<DepartmentViewModel>();
    final yearVm = context.watch<YearViewmodel>();
    final viewModel = Provider.of<StudentViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(title: 'Student'),
        centerTitle: true,
        leading: BackItem(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: DefaultTextField(
                      hint: 'Search by name, code, or dept...',
                      prefixIcon: Icon(Icons.search),
                      onChanged: viewModel.search,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Add',
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MultiProvider(
                              providers: [
                                ChangeNotifierProvider.value(
                                  value: context.read<StudentViewModel>(),
                                ),
                                ChangeNotifierProvider.value(
                                  value: context.read<DepartmentViewModel>(),
                                ),
                                ChangeNotifierProvider.value(
                                  value: context.read<YearViewmodel>(),
                                ),
                              ],
                              child: AddStudentView(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
                                    value: context.read<DepartmentViewModel>(),
                                  ),
                                  ChangeNotifierProvider.value(
                                    value: context.read<YearViewmodel>(),
                                  ),
                                ],
                                child: const StudentDetailsView(),
                              ),
                              settings: RouteSettings(
                                arguments: {'user': user},
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
    );
  }
}
