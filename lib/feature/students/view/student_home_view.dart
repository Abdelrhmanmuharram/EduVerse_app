import 'package:edusync_app/feature/students/view/student_chat_bot_view.dart';
import 'package:edusync_app/feature/students/view/student_dashboard_view.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/nav_bar_icons.dart';
import '../../admin/home/view/profile_view.dart';

class StudentHomeView extends StatefulWidget {
  static const String routeName = '/student-home';
  const StudentHomeView({super.key});

  @override
  State<StudentHomeView> createState() => _StudentHomeViewState();
}

class _StudentHomeViewState extends State<StudentHomeView> {
  int currentIndex = 0;
  List<Widget> taps = [StudentDashboardView(), StudentChatBotView(), ProfileView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: taps[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: NavBarIcons(iconName: 'panel'),
            activeIcon: NavBarIcons(iconName: 'panel_active'),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: NavBarIcons(iconName: 'chat_bot'),
            activeIcon: NavBarIcons(iconName: 'chat_bot_active'),
            label: 'AI Chat',
          ),
          BottomNavigationBarItem(
            icon: NavBarIcons(iconName: 'profile'),
            activeIcon: NavBarIcons(iconName: 'profile_active'),
            label: 'Profile',
          ),
        ]
      )
    );
  }
}
