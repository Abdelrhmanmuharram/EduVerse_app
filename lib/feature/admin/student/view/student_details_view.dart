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
  String? originalYear;
  String? selectedYear;
  bool isInit = false;
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
      selectedDepartmentId = user.departmentId;
      originalDepartmentId = user.departmentId;
      selectedYear = user.yearId?.toString();
      originalYear = user.yearId?.toString();
      idController.text = user.id;
      fullNameController.text = user.fullName;
      emailController.text = user.email;
      roleController.text = user.roles[0];
      originalFullName = user.fullName;
      isInit = true;


    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    final studentVm = context.watch<StudentViewModel>();
    final departmentVm = context.watch<DepartmentViewModel>();
    String? selectedDepartmentName;
    if (departmentVm.departments.isNotEmpty) {
      final department = departmentVm.departments.where(
            (d) => d.id == selectedDepartmentId,
      );
      if (department.isNotEmpty) {
        selectedDepartmentName = department.first.englishName;
      }
    }
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: BackItem(),
            title: Text('Update Student', style: textTheme.headlineSmall),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(height: 14),
                  Center(child: StudentAvatar()),
                  SizedBox(height: 12),
                  Center(
                    child: FieldLabel(
                      label: 'Student ID: #${idController.text}',
                    ),
                  ),
                  SizedBox(height: 24),
                  FieldLabel(label: 'Student Code'),
                  SizedBox(height: 6),
                  DefaultTextField(
                    hint: 'Enter your code',
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/code.svg',
                      width: 24,
                      height: 24,
                      fit: .scaleDown,
                    ),
                    controller: idController,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                  ),
                  SizedBox(height: 6),
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
                    selectedItem: selectedDepartmentName,
                    onChanged: (value) {
                      setState(() {
                        selectedDepartmentId = departmentVm.departments
                            .firstWhere((d) => d.englishName == value)
                            .id;
                      });
                    },
                  ),
                  SizedBox(height: 6),
                  FieldLabel(label: 'Academic Year'),
                  SizedBox(height: 6),
                  DefaultDropDownField(
                    icon: 'year',
                    hint: 'Select year',
                    items: ["Year 1", "Year 2", "Year 3", "Year 4"],
                    selectedItem: selectedYear,
                    onChanged: (value) {
                      setState(() {
                        selectedYear = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  PrimaryButton(
                    label: 'Update Student',
                    onPressed: () async {
                      final hasChanges =
                          fullNameController.text != originalFullName ||
                          selectedDepartmentId != originalDepartmentId ||
                          selectedYear != originalYear;
                      if (!hasChanges) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No changes detected')),
                        );
                        return;
                      }
                      final args =
                          ModalRoute.of(context)!.settings.arguments
                              as Map<String, dynamic>;
                      final departmentVm = context.read<DepartmentViewModel>();
                      debugPrint('Selected Department = $selectedDepartmentId');
                      for (final d in departmentVm.departments) {
                        debugPrint('Department => ${d.id} | ${d.englishName}');
                        debugPrint(
                          'Selected Department = $selectedDepartmentId',
                        );
                      }
                      final student = UpdateStudentModel(
                        id: idController.text,
                        fullName: fullNameController.text,
                        departmentId: selectedDepartmentId!,
                      );
                      await context.read<StudentViewModel>().updateStudent(
                        student,
                      );
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
