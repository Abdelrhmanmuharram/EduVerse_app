import 'package:edusync_app/core/widgets/nav_bar_icons.dart';
import 'package:edusync_app/feature/admin/home/view/profile_view.dart';
import 'package:edusync_app/feature/admin/home/view/panel_view.dart';
import 'package:flutter/material.dart';

import '../../chat_bot/view/chat_bot_view.dart';

class AdminHomeView extends StatefulWidget {
  static const String routeName = '/home';

  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<AdminHomeView> {
  int currentIndex = 0;
  List<Widget> taps = [PanelView(), ProfileView()];
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
            label: 'Panel',
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
