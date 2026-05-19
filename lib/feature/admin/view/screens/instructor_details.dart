import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/default_button.dart';
import '../../model/instructor_model.dart';
import '../../model/subject_model.dart';
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
  List<SubjectModel> subjects = [];
  late InstructorsModel instructor;
  bool isLoaded = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!isLoaded){
      instructor =
          ModalRoute.of(context)!.settings.arguments as InstructorsModel;
      fullNameController.text = instructor.fullName;
      emailController.text = instructor.email;
      subjects = List.from(instructor.subjects);
      isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
                  subjects: subjects,
                  onChanged: (newList) {
                      subjects = newList;
                      setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Edit',
                  onPressed: () {
                    final updatedInstructor = InstructorsModel(
                      email: emailController.text,
                      fullName: fullNameController.text,
                      password: instructor.password,
                      subjects: subjects,
                    );
                    Navigator.pop(context, updatedInstructor);
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
