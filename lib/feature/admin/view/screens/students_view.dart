import 'package:edusync_app/feature/admin/view/screens/add_student_view.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/feature/admin/model/student_model.dart';
import 'package:edusync_app/feature/admin/view/screens/student_details_view.dart';
import 'package:edusync_app/feature/admin/view/widgets/student_table.dart';
import 'package:edusync_app/feature/admin/view/widgets/student_header.dart';
import 'package:flutter/material.dart';

import '../../model/add_student_model.dart';

class StudentsView extends StatefulWidget {
  static const String routeName = '/students';

  @override
  State<StudentsView> createState() => _StudentsViewState();
}

class _StudentsViewState extends State<StudentsView> {
  Map<String, String> deptShort = {
    "Computer Science": "CS",
    "Information Systems": "IS",
    "AI": "AI",
    "Cyber Security": "CSec",
  };
  List<AddStudentModel> students = [];
  String searchQuery = '';
  int currentPage = 1;
  List<AddStudentModel> get filteredStudents {
    if (searchQuery.isEmpty) return students;
    return students.where((student) {
      return student.firstName.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          student.code.toLowerCase().contains(searchQuery.toLowerCase()) ||
          student.department.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void onRowTap(Student student) {
    Navigator.pushNamed(
      context,
      StudentDetailsView.routeName,
      arguments: student,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 20),
                StudentHeader(),
                SizedBox(height: 24),
                DefaultTextField(
                  hint: 'Search by name, code, or dept...',
                  prefixIcon: Icon(Icons.search),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                      currentPage = 1;
                    });
                  },
                ),
                SizedBox(height: 12),
                StudentTable(
                  students: filteredStudents.map((student) {
                    return Student(
                      code: student.code,
                      name: student.firstName,
                      dept: deptShort[student.department] ?? student.department,
                      year: student.academicYear,
                    );
                  }).toList(),
                  onRowTap: onRowTap,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 48,
        width: 48,
        child: Transform.translate(
          offset: Offset(-5, 20),
          child: FloatingActionButton(
            onPressed: () async {
              final student = await Navigator.of(
                context,
              ).pushNamed(AddStudentView.routeName);
              if (student != null) {
                setState(() {
                  students.add(student as AddStudentModel);
                });
              }
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
