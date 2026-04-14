import 'package:edusync_app/core/widgets/nav_bar_icons.dart';
import 'package:edusync_app/feature/admin/view/screens/alerts_view.dart';
import 'package:edusync_app/feature/admin/view/screens/panel_view.dart';
import 'package:edusync_app/feature/admin/view/screens/reports_view.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int currentIndex = 0;

  List<Widget> taps = [PanelView(), AlertsView(), ReportsView()];

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
            icon: NavBarIcons(iconName: 'reports'),
            activeIcon: NavBarIcons(iconName: 'reports_active'),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: NavBarIcons(iconName: 'alerts'),
            activeIcon: NavBarIcons(iconName: 'alerts_active'),
            label: 'Alerts',
          ),
        ],
      ),
    );
  }
}
