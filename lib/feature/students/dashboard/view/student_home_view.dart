import 'package:edusync_app/feature/students/dashboard/view/student_dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/nav_bar_icons.dart';
import '../../../admin/home/view/profile_view.dart';
import '../../chat_bot/data/remote/chat_bot_remote_data_source_impl.dart';
import '../../chat_bot/repository/chat_bot_repository_impl.dart';
import '../../chat_bot/view/chat_bot_view.dart';
import '../../chat_bot/view_model/student_chat_bot_view_model.dart';
import '../../materials/data/remote/student_material_remote_data_source_impl.dart';
import '../../materials/data/remote/student_subject_remote_data_source_impl.dart';
import '../../materials/repository/student_material_repository_impl.dart';
import '../../materials/repository/student_subject_repository_impl.dart';
import '../../semester/data/remote/system_setting_remote_data_source_impl.dart';
import '../../semester/repository/system_setting_repository_impl.dart';

class StudentHomeView extends StatefulWidget {
  static const String routeName = '/student-home';
  const StudentHomeView({super.key});

  @override
  State<StudentHomeView> createState() => _StudentHomeViewState();
}

class _StudentHomeViewState extends State<StudentHomeView> {
  late final List<Widget> taps;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    taps = [
      StudentDashboardView(),
      ChangeNotifierProvider(
        create: (_) => StudentChatBotViewModel(
          StudentSubjectRepositoryImpl(
            remoteDataSource: StudentSubjectRemoteDataSourceImpl(),
          ),
          SystemSettingRepositoryImpl(SystemSettingRemoteDataSourceImpl()),
          StudentMaterialRepositoryImpl(StudentMaterialRemoteDataSourceImpl()),
          ChatBotRepositoryImpl(ChatBotRemoteDataSourceImpl()),
        )..loadData(),
        child: const StudentChatBotView(),
      ),
      ProfileView(),
    ];
  }

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
        ],
      ),
    );
  }
}
