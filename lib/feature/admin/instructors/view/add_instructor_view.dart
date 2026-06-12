import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/primary_button.dart';
import '../viewmodel/instructor_viewmodel.dart';
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

  @override
  void initState() {
    super.initState();
    // بننتظر الـ frame الأول يخلص الأول عشان نعمل notifyListeners بأمان
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<InstructorViewModel>();
      viewModel.updateSubjects([]);
      viewModel.loadAllSubjects();
    });
  }

  void _saveInstructor() {
    if (!_formKey.currentState!.validate()) return;
    final viewModel = context.read<InstructorViewModel>();
    viewModel
        .addInstructor(
      email: emailController.text.trim(),
      fullName: fullNameController.text.trim(),
      password: passwordController.text.trim(),
      departmentId: null,
    ).then((instructorId) async {
      if (instructorId != null) {
        await viewModel.bulkUpsertSubjects(instructorId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Instructor added successfully')),
          );
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add instructor')),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                  allSubjects: viewModel.allSubjects,
                  subjects: viewModel.subjects,
                  onChanged: (newList) {
                    viewModel.updateSubjects(newList);
                  },
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Save',
                  onPressed: _saveInstructor,
                  isLoading: viewModel.isLoading,
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