import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../viewmodel/instructors_viewmodel.dart';
import '../../viewmodel/students_list_viewmodel.dart';
import '../widgets/attendance_card_widget.dart';
import '../widgets/instructor_header_widget.dart';
import '../widgets/instructor_menu_card.dart';

class InstructorsHomeView extends StatelessWidget {
  static const String routeName = '/instructors-home';
  final viewModel = InstructorsViewModel();
  InstructorsHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final studentsViewModel = context.watch<StudentsListViewModel>();
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            InstructorHeaderWidget(),
            const SizedBox(height: 20),
            AttendanceCardWidget(),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: viewModel.menu.length,
                itemBuilder: (context, index) {
                  final item = viewModel.menu[index];
                  final subtitle = item["title"] == "Students List"
                      ? "${studentsViewModel.studentsCount} total students"
                      : item["subtitle"];
                  return InstructorMenuCard(
                    title: item["title"],
                    subtitle: subtitle,
                    icon: item["icon"],
                    onTap: () {
                      switch (item["title"]) {
                        case "Materials":
                          Navigator.pushNamed(context, '/materials');
                          break;
                        case "Students List":
                          Navigator.pushNamed(context, '/students_list');
                          break;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
