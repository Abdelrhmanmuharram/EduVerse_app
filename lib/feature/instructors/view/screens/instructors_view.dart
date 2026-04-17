import 'package:flutter/material.dart';
import 'package:edusync_app/core/app_theme.dart';

import '../../viewmodel/instructors_viewmodel.dart';
import '../widgets/instructor_header_widget.dart';
import '../widgets/attendance_card_widget.dart';
import '../widgets/instructor_menu_card.dart';

class InstructorsView extends StatelessWidget {
  static const routeName = "/instructors";

  final viewModel = InstructorsViewModel();

  InstructorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,

      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            /// Header
            InstructorHeaderWidget(),

            const SizedBox(height: 20),

            /// Attendance Card
            AttendanceCardWidget(),

            const SizedBox(height: 20),

            /// Menu Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),

                itemCount: viewModel.menu.length,

                itemBuilder: (context, index) {
                  final item = viewModel.menu[index];

                  return InstructorMenuCard(
                    title: item["title"],
                    subtitle: item["subtitle"],
                    icon: item["icon"],


                    onTap: () {
                      switch (item["title"]) {

                        case "Subjects":
                          Navigator.pushNamed(context, '/subjects');
                          break;

                        case "Materials":
                          break;

                        case "Students List":
                          Navigator.pushNamed(context, '/students_list');
                          break;

                        case "Reports":

                          break;
                      }
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            /// Bottom Nav
            BottomNavigationBar(
              currentIndex: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: "Profile",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}