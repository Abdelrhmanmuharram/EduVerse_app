import 'package:flutter/material.dart';
import 'package:edusync_app/core/app_theme.dart';
import '../../viewmodel/students_list_viewmodel.dart';

class StudentsListView extends StatelessWidget {
  static const routeName = "/students_list";

  final viewModel = StudentsListViewModel();

  StudentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,

      appBar: AppBar(
        title: Text(
          "Student List",
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

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 16),

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

                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(

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

            /// 📊 TABLE
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: DataTable(

                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryLight,
                    ),

                    columns: const [
                      DataColumn(label: Text("ID")),
                      DataColumn(label: Text("Name")),
                      DataColumn(label: Text("Email")),
                      DataColumn(label: Text("Status")),
                    ],

                    rows: viewModel.students.map((student) {
                      return DataRow(
                        cells: [
                          DataCell(Text(student["id"] ?? "")),
                          DataCell(Text(student["name"] ?? "")),
                          DataCell(Text(student["email"] ?? "")),
                          DataCell(Text(student["status"] ?? "")),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}