import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/primary_button.dart';
import '../model/instructor_model.dart';
import '../widgets/instructor_card.dart';

class AdminInstructorsView extends StatefulWidget {
  static const String routeName = '/instructors';
  const AdminInstructorsView({super.key});

  @override
  State<AdminInstructorsView> createState() => _AdminInstructorsViewState();
}

class _AdminInstructorsViewState extends State<AdminInstructorsView> {
  List<InstructorsModel> instructors = [];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            'assets/icons/back.svg',
            width: 24,
            height: 24,
            fit: .scaleDown,
          ),
        ),
        title: Text('Instructors', style: textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            DefaultTextField(
              hint: 'Search by username, code',
              prefixIcon: Icon(Icons.search, color: AppTheme.hintText),
            ),
            InstructorCard(
              instructors: instructors,
            ),
            PrimaryButton(
              label: 'Add Instructor',
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  '/add-instructor',
                );
                if (result != null) {
                  setState(() {
                    instructors.add(result as InstructorsModel);
                  });
                }
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
