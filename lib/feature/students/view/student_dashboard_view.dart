import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:edusync_app/feature/students/widgets/subject_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../view_model/student_dashboard_view_model.dart';
import '../widgets/dashboard_header.dart';

class StudentDashboardView extends StatelessWidget {
  static const String routeName = '/student-dashboard';
  const StudentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<StudentDashboardViewModel>();
    if (viewModel.errorMessage != null) {
      return Scaffold(body: Center(child: Text(viewModel.errorMessage!)));
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              DashboardHeader(studentName: viewModel.user?.fullName ?? ''),
              const SizedBox(height: 8),
              DefaultTextField(
                hint: 'Search',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Your Subjects',
                    style: textTheme.titleLarge!.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'View All',
                    style: textTheme.titleSmall!.copyWith(
                      color: AppTheme.primaryLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: viewModel.isLoading
                    ? LoadingWidget()
                    : SubjectListItem(vm: viewModel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
