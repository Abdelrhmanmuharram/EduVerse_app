import 'package:edusync_app/core/widgets/nav_bar_icons.dart';
import 'package:edusync_app/feature/admin/home/view/profile_view.dart';
import 'package:edusync_app/feature/admin/home/view/panel_view.dart';
import 'package:edusync_app/feature/instructors/view/screens/instructors_home_view.dart';
import 'package:flutter/material.dart';

class InstructorView extends StatefulWidget {
  static const String routeName = '/instructors-view';
  const InstructorView({super.key});

  @override
  State<InstructorView> createState() => _HomeAdminState();
}
class _HomeAdminState extends State<InstructorView> {
  int currentIndex = 0;
  List<Widget> taps = [InstructorsHomeView(), ProfileView(),];
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
            icon: NavBarIcons(iconName: 'instructors-home-deactivate'),
            activeIcon: NavBarIcons(iconName: 'instructor-home-active'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: NavBarIcons(iconName: 'profile'),
            activeIcon: NavBarIcons(iconName: 'profile_active'),
            label: 'profile',
          ),

        ],
      ),
    );
  }
}
