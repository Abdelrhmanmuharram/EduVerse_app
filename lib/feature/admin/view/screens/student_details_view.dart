import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_drop_down_field.dart';
import '../../../../core/widgets/default_field_lable.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../model/add_student_model.dart';
import '../../model/student_model.dart';
import '../widgets/student_avatar.dart';

class StudentDetailsView extends StatefulWidget {
  static const String routeName = '/student-details';
  const StudentDetailsView({super.key});

  @override
  State<StudentDetailsView> createState() => _StudentDetailsViewState();
}

class _StudentDetailsViewState extends State<StudentDetailsView> {
  String? selectedDepartment;
  String? selectedYear;
  bool isInit = false;
  final TextEditingController codeController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController arabicNameController = TextEditingController();
  final TextEditingController englishFullNameController =
      TextEditingController();

  @override
  void didChangeDependencies() {
    if (!isInit) {
      final student = ModalRoute.of(context)!.settings.arguments as AddStudentModel;
      codeController.text = student.code;
      firstNameController.text = student.firstName;
      lastNameController.text = student.lastName;
      arabicNameController.text = student.arabicName;
      englishFullNameController.text = student.englishFullName;
      selectedDepartment = student.department;
      selectedYear = student.academicYear;
      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
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
              Center(child: FieldLabel(label: 'Student ID: #${codeController.text}')),
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
                controller: codeController,
                keyboardType: TextInputType.text,
                readOnly: true,
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
                controller: firstNameController,
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
                controller: lastNameController,
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
                controller: arabicNameController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 6),
              FieldLabel(label: 'English Full Name'),
              SizedBox(height: 6),
              DefaultTextField(
                hint: 'Full name',
                prefixIcon: Icon(Icons.person_outline),
                controller: englishFullNameController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 6),
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
                      textColor: AppTheme.blueGray,
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
                          code: codeController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          arabicName: arabicNameController.text,
                          englishFullName: englishFullNameController.text,
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
