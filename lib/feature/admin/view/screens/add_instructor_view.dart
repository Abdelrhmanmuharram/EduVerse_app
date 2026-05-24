import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/default_button.dart';
import '../../model/subject_model.dart';
import '../../viewmodel/instructor_viewmodel.dart';
import '../widgets/assign_subject.dart';
import '../widgets/instructor_profile.dart';

class AddInstructorView extends StatefulWidget {
  static const String routeName = '/add-instructor';

  const AddInstructorView({super.key});

  @override
  State<AddInstructorView> createState() => _AddInstructorViewState();
}

class _AddInstructorViewState extends State<AddInstructorView> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedRole;
  List<SubjectModel> subjects = [];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<InstructorViewModel>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Instructor', style: textTheme.headlineSmall),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            'assets/icons/back.svg',
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                InstructorProfile(
                  emailController: emailController,
                  passwordController: passwordController,
                  fullNameController: fullNameController,
                  onRoleChanged: (value) {
                    setState(() {
                      selectedRole = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                AssignSubject(
                  subjects: subjects,
                  onChanged: (newList) {
                    setState(() {
                      subjects = newList;
                    });
          
                  },
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Save',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await viewModel.addInstructor(
                        email: emailController.text.trim(),
                        fullName: fullNameController.text.trim(),
                        password: passwordController.text.trim(),
                        departmentId: 3364,
                      );
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Instructor added successfully',
                            ),
                          ),
                        );
          
                        Navigator.pop(context);
          
                      } else {
          
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Failed to add instructor',
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}