import 'package:flutter/material.dart';
import 'package:edusync_app/core/app_theme.dart';
import '../../viewmodel/students_list_viewmodel.dart';

// 🔥 دول اللي بعتهم
import 'package:edusync_app/feature/admin/view/widgets/student_header.dart';
import 'package:edusync_app/feature/admin/view/widgets/student_table.dart';

class StudentsListView extends StatelessWidget {
  static const routeName = "/students_list";

  final viewModel = StudentsListViewModel();

  StudentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,

      appBar: AppBar(
        title: const Text("Student List"),
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

            /// 🔥 HEADER (اللي بعتّه)
            StudentHeader(),

            const SizedBox(height: 16),

            /// 🔍 SEARCH
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [

                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 20,
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search students...",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        filled: false,
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: StudentTable(
                  students: viewModel.students,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}