import 'package:edusync_app/core/widgets/default_field_lable.dart';
import 'package:edusync_app/feature/admin/student/widgets/student_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/default_drop_down_field.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../model/add_student_model.dart';

class AddStudentView extends StatefulWidget {
  static const String routeName = '/add-student';

  const AddStudentView({super.key});

  @override
  State<AddStudentView> createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  String? selectedDepartment;
  String? selectedYear;
  final TextEditingController idController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text('Add Student', style: textTheme.headlineSmall),
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
              ),
              SizedBox(height: 6),
              FieldLabel(label: 'First Name'),
              SizedBox(height: 6),
              DefaultTextField(
                hint: 'Enter your first name',
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
              FieldLabel(label: 'Last Name'),
              SizedBox(height: 6),
              DefaultTextField(
                hint: 'Enter your last name',
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
              FieldLabel(label: 'Arabic Name'),
              SizedBox(height: 6),
              DefaultTextField(
                hint: 'Arabic name',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/language.svg',
                  width: 24,
                  height: 24,
                  fit: .scaleDown,
                ),
                controller: roleController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 6),
              FieldLabel(label: 'English Full Name'),
              FieldLabel(label: 'Department'),
              SizedBox(height: 6),
              DefaultDropDownField(
                icon: 'department',
                hint: 'Select department',
                items: [
                  "Computer Science",
                  "Information Systems",
                  "AI",
                  "Cyber Security",
                ],
                selectedItem: selectedDepartment,
                onChanged: (value) {
                  setState(() {
                    selectedDepartment = value;
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
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      color: AppTheme.flashWhite,
                      textColor: AppTheme.black,
                      label: 'Back',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    flex: 2,
                    child: PrimaryButton(
                      label: 'Add Student',
                      onPressed: () {
                        AddStudentModel student = AddStudentModel(
                          id: idController.text,
                          fullName: fullNameController.text,
                          email: emailController.text,
                          role: roleController.text,
                          department: selectedDepartment ?? '',
                          academicYear: selectedYear ?? '',
                        );
                        Navigator.pop(context, student);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }
}
