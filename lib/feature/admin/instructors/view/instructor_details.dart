import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/model/user_model.dart';
import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/primary_button.dart';
import '../viewmodel/instructor_viewmodel.dart';
import '../widgets/assign_subject.dart';
import '../widgets/instructor_profile.dart';

class InstructorDetails extends StatefulWidget {
  static const String routeName = '/instructor-details';
  const InstructorDetails({super.key});

  @override
  State<InstructorDetails> createState() => _InstructorDetailsState();
}

class _InstructorDetailsState extends State<InstructorDetails> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late UserModel instructor;
  bool isLoaded = false;
  final _formKey = GlobalKey<FormState>();

  @override
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      instructor = ModalRoute.of(context)!.settings.arguments as UserModel;
      fullNameController.text = instructor.fullName;
      emailController.text = instructor.email;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final viewModel = context.read<InstructorViewModel>();
        viewModel.loadInstructorSubjects(instructor.id);
        viewModel.loadAllSubjects();
      });
      isLoaded = true;
    }
  }

  Future<void> _saveInstructor() async {
    if (!_formKey.currentState!.validate()) return;
    final viewModel = context.read<InstructorViewModel>();
    final profileChanged =
        fullNameController.text.trim() != instructor.fullName ||
        emailController.text.trim() != instructor.email;
    if (!profileChanged && !viewModel.hasSubjectsChanged()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No changes detected')));
      return;
    }
    final success = await viewModel.saveInstructor(
      instructorId: instructor.id,
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      departmentId: instructor.departmentId,
    );
    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Instructor updated successfully')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update instructor')),
      );
    }
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
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<InstructorViewModel>();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Edit Instructor', style: textTheme.headlineSmall),
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
                      onRoleChanged: (value) {},
                      showPassword: false,
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
        ),
        if (viewModel.isLoading)
          Container(
            color: AppTheme.black.withOpacity(0.5),
            child: const Center(child: LoadingWidget()),
          ),
      ],
    );
  }
}
