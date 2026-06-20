import 'package:edusync_app/core/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/default_drop_down_field.dart';
import '../../../../core/widgets/default_field_lable.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../../years/viewmodel/year_viewmodel.dart';
import '../../departments/viewmodel/departement_viewmodel.dart';
import '../model/add_student_model.dart';
import '../model/update_student_model.dart';
import '../viewmodel/student_viewmodel.dart';
import '../widgets/student_avatar.dart';

class StudentDetailsView extends StatefulWidget {
  static const String routeName = '/student-details';
  const StudentDetailsView({super.key});

  @override
  State<StudentDetailsView> createState() => _StudentDetailsViewState();
}

class _StudentDetailsViewState extends State<StudentDetailsView> {
  String? originalFullName;
  int? originalDepartmentId;
  int? selectedDepartmentId;
  int? originalYearId;
  int? selectedYearId;
  bool isInit = false;
  bool showYearError = false;
  String? selectedDepartmentName;
  final TextEditingController idController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (!isInit) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final user = args['user'] as UserModel;
      fullNameController.text = user.fullName;
      selectedDepartmentId = user.departmentId;
      selectedYearId = user.yearId;
      idController.text = user.id;
      emailController.text = user.email;
      roleController.text = user.roles.isNotEmpty ? user.roles.first : '';
      isInit = true;
      context.read<StudentViewModel>().initializeStudent(user);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final studentVm = context.watch<StudentViewModel>();
    final departmentVm = context.watch<DepartmentViewModel>();
    final yearVm = context.watch<YearViewmodel>();

    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: BackItem(),
            title: Text('Update Student', style: textTheme.headlineSmall),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 14),
                Center(child: StudentAvatar()),
                SizedBox(height: 24),
                FieldLabel(label: 'Full Name'),
                SizedBox(height: 6),
                DefaultTextField(
                  hint: 'Full Name',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/name.svg',
                    width: 24,
                    height: 24,
                    fit: .scaleDown,
                  ),
                  controller: fullNameController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 6),
                FieldLabel(label: 'Email'),
                SizedBox(height: 6),
                DefaultTextField(
                  hint: 'Enter your Email',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/name.svg',
                    width: 24,
                    height: 24,
                    fit: .scaleDown,
                  ),
                  controller: emailController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 6),
                FieldLabel(label: 'Role'),
                SizedBox(height: 6),
                DefaultTextField(
                  readOnly: true,
                  hint: '',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/user_role.svg',
                    width: 24,
                    height: 24,
                    fit: .scaleDown,
                  ),
                  controller: roleController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 6),
                FieldLabel(label: 'Department'),
                SizedBox(height: 6),
                DefaultDropDownField(
                  icon: 'department',
                  hint: 'Select department',
                  items: departmentVm.departments
                      .map((d) => d.englishName)
                      .toList(),
                  selectedItem: studentVm.getDepartmentName(
                    selectedDepartmentId,
                    departmentVm.departments,
                  ),
                  onChanged: (value) {
                    final department = departmentVm.departments.firstWhere(
                      (d) => d.englishName == value,
                    );
                    setState(() {
                      selectedDepartmentId = department.id;
                    });
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
                  selectedItem: studentVm.getYearName(
                    selectedYearId,
                    yearVm.years,
                  ),
                  onChanged: (value) {
                    final year = yearVm.years.firstWhere(
                      (y) => y.engName == value,
                    );
                    setState(() {
                      selectedYearId = year.id;
                    });
                  },
                ),
                SizedBox(height: 16),
                Spacer(),
                PrimaryButton(
                  label: 'Save',
                  onPressed: () async {
                    final hasChanges = studentVm.hasChanges(
                      currentName: fullNameController.text,
                      currentDepartmentId: selectedDepartmentId,
                      currentYearId: selectedYearId,
                    );
                    if (!hasChanges) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No changes detected')),
                      );
                      return;
                    }
                    debugPrint('Selected Department = $selectedDepartmentId');
                    final student = UpdateStudentModel(
                      id: idController.text,
                      fullName: fullNameController.text,
                      email: emailController.text,
                      departmentId: selectedDepartmentId!,
                      yearId: selectedYearId!,
                    );
                    await studentVm.updateStudent(student);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(height: 14),
              ],
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
