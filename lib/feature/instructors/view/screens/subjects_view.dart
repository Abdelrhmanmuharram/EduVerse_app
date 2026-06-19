import 'package:flutter/material.dart';
import 'package:edusync_app/core/app_theme.dart';
import '../../../admin/instructors/data/remote/instructor_subject_remote_data_source_impl.dart';
import '../../../admin/instructors/repository/instructor_subject_repository_impl.dart';
import '../../data/remote/materials_remote_data_source_impl.dart';
import '../../repository/materials_repository_impl.dart';
import '../../viewmodel/materials_viewmodel.dart';
import '../widgets/attendance_summary_card.dart';
import 'package:edusync_app/feature/instructors/view/widgets/materials_section.dart';
import 'package:edusync_app/feature/instructors/viewmodel/materials_viewmodel.dart';

class SubjectsView extends StatelessWidget {
  static const routeName = "/subjects";

  final viewModel = MaterialsViewModel(
    MaterialsRepositoryImpl(MaterialsRemoteDataSourceImpl()),
    InstructorSubjectRepositoryImpl(InstructorSubjectRemoteDataSourceImpl()),
  );

  SubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: Text(
          "Subject: Advanced Calculus",
          style: textTheme.headlineSmall,
        ),
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

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              MaterialsSection(materials: viewModel.materials),
              const SizedBox(height: 20),
              AttendanceSummaryCard(),
              const SizedBox(height: 20),
              _StatCard(title: "TOTAL STUDENTS", value: "42"),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryLight,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text("Take Attendance"),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;

  const _StatCard({required this.title, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppTheme.secondText, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color ?? AppTheme.black,
            ),
          ),
        ],
      ),
    );
  }
}
