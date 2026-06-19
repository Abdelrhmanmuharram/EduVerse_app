import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/students_list_viewmodel.dart';
import '../widgets/students_table.dart';

class StudentsListView extends StatelessWidget {
  static const routeName = "/students_list";

  const StudentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: Text("Student List", style: textTheme.headlineSmall),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppTheme.primaryLight,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            DefaultTextField(
              onChanged: (value) {
                context.read<StudentsListViewModel>().searchStudents(value);
              },
              hint: 'Search',
              prefixIcon: SvgPicture.asset('assets/icons/search.svg',
                height: 24,
                width: 24,
                fit: .scaleDown,),
            ),
            const SizedBox(height: 20),
            StudentsTable(),
          ],
        ),
      ),
    );
  }
}
