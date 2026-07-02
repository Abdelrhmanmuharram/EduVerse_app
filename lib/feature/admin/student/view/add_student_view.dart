import 'package:edusync_app/core/helpers/roles.dart';
import 'package:edusync_app/core/widgets/back_item.dart';
import 'package:edusync_app/core/widgets/default_field_lable.dart';
import 'package:edusync_app/feature/admin/student/widgets/student_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/default_drop_down_field.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../../years/viewmodel/year_viewmodel.dart';
import '../../departments/viewmodel/departement_viewmodel.dart';
import '../model/add_student_model.dart';
import '../viewmodel/student_viewmodel.dart';

class AddStudentView extends StatefulWidget {
  static const String routeName = '/add-student';

  const AddStudentView({super.key});

  @override
  State<AddStudentView> createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  int? selectedDepartmentId;
  int? selectedYearId;
  bool showDepartmentError = false;
  bool showYearError = false;
  final TextEditingController idController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final departmentVm = context.watch<DepartmentViewModel>();
    final studentVm = context.watch<StudentViewModel>();
    final yearVm = context.watch<YearViewmodel>();
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: BackItem(),
            title: Text('Add Student', style: textTheme.headlineSmall),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(height: 14),
                  Center(child: StudentAvatar()),
                  SizedBox(height: 24),
                  FieldLabel(label: 'Full Name'),
                  SizedBox(height: 6),
                  DefaultTextField(
                    textInputAction: TextInputAction.next,
                    hint: 'Enter your name',
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/name.svg',
                      width: 24,
                      height: 24,
                      fit: .scaleDown,
                    ),
                    controller: fullNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) =>
                        AppValidators.requiredField(value, 'Full Name'),
                  ),
                  SizedBox(height: 6),
                  FieldLabel(label: 'Email'),
                  SizedBox(height: 6),
                  DefaultTextField(
                    textInputAction: TextInputAction.next,
                    hint: 'Enter your email',
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/@.svg',
                      width: 24,
                      height: 24,
                      fit: .scaleDown,
                    ),
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    validator: AppValidators.emailValidator,
                  ),
                  SizedBox(height: 6),
                  FieldLabel(label: 'Password'),
                  SizedBox(height: 6),
                  DefaultTextField(
                    textInputAction: TextInputAction.done,
                    hint: 'Password',
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/password.svg',
                      width: 24,
                      height: 24,
                      fit: .scaleDown,
                    ),
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    validator: AppValidators.passwordValidator,
                    isPassword: true,
                  ),
                  SizedBox(height: 6),
                  FieldLabel(label: 'Department'),
                  SizedBox(height: 6),
                  DefaultDropDownField(
                    icon: 'department',
                    hint: 'Select department',
                    errorText: showDepartmentError
                        ? 'Please select a department'
                        : null,
                    items: departmentVm.departments
                        .map((d) => d.englishName)
                        .toList(),
                    selectedItem:
                        departmentVm.departments
                            .where((d) => d.id == selectedDepartmentId)
                            .isNotEmpty
                        ? departmentVm.departments
                              .firstWhere((d) => d.id == selectedDepartmentId)
                              .englishName
                        : null,
                    onChanged: (value) {
                      final department = departmentVm.departments.firstWhere(
                        (d) => d.englishName == value,
                      );
                      setState(() {
                        selectedDepartmentId = department.id;
                      });
                      debugPrint('Department Id = $selectedDepartmentId');
                    },
                  ),
                  SizedBox(height: 6),
                  FieldLabel(label: 'Academic Year'),
                  SizedBox(height: 6),
                  DefaultDropDownField(
                    icon: 'year',
                    hint: 'Select year',
                    errorText: showYearError ? 'Please select a year' : null,
                    items: yearVm.years.map((y) => y.engName).toList(),
                    selectedItem:
                        yearVm.years
                            .where((y) => y.id == selectedYearId)
                            .isNotEmpty
                        ? yearVm.years
                              .firstWhere((y) => y.id == selectedYearId)
                              .engName
                        : null,
                    onChanged: (value) {
                      final year = yearVm.years.firstWhere(
                        (y) => y.engName == value,
                      );
                      setState(() {
                        selectedYearId = year.id;
                      });
                      debugPrint('Year Id = $selectedYearId');
                    },
                  ),

                  SizedBox(height: 16),
                  Spacer(),
                  PrimaryButton(
                    label: 'Save',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          showDepartmentError = selectedDepartmentId == null;
                          showYearError = selectedYearId == null;
                        });
                        if (selectedDepartmentId == null ||
                            selectedYearId == null) {
                          return;
                        }
                        debugPrint('DepartmentId = $selectedDepartmentId');
                        debugPrint('YearId = $selectedYearId');
                        final student = AddStudentModel(
                          fullName: fullNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          role: Roles.roleStudent,
                          departmentId: selectedDepartmentId!,
                          yearId: selectedYearId!,
                        );
                        await context.read<StudentViewModel>().addStudent(
                          student,
                        );
                        Navigator.pop(context, student);
                      }
                    },
                  ),
                  SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ),
        if (studentVm.isLoading)
          Container(
            color: AppTheme.black.withValues(alpha: 0.4),
            child: const Center(child: LoadingWidget()),
          ),
      ],
    );
  }
}
