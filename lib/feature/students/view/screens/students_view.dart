import 'package:edusync_app/addstudent/add_student_view.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/feature/students/model/student_model.dart';
import 'package:edusync_app/feature/students/view/widgets/student_table.dart';
import 'package:edusync_app/feature/students/view/widgets/student_header.dart';
import 'package:flutter/material.dart';

class StudentsView extends StatelessWidget {
  static const String routeName = '/students';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 20),
              StudentHeader(),
              SizedBox(height: 24),
              DefaultTextField(
                hint: 'Search by name, code, or dept...',
                prefixIcon: Icons.search,
              ),
              SizedBox(height: 12),
              StudentTable(
                students: [
                  Student(
                    code: '0000',
                    name: 'Muharram',
                    dept: 'IT',
                    year: '2026',
                  ),
                  Student(
                    code: '0000',
                    name: 'Muharram',
                    dept: 'IT',
                    year: '2026',
                  ),
                  Student(
                    code: '0000',
                    name: 'Muharram',
                    dept: 'IT',
                    year: '2026',
                  ),
                  Student(
                    code: '0000',
                    name: 'Muharram',
                    dept: 'IT',
                    year: '2026',
                  ),
                  Student(
                    code: '0000',
                    name: 'Muharram',
                    dept: 'IT',
                    year: '2026',
                  ),
                  Student(
                    code: '0000',
                    name: 'Muharram',
                    dept: 'IT',
                    year: '2026',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 48,
        width: 48,
        child: Transform.translate(
          offset: Offset(-5, 20),
          child: FloatingActionButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddStudentView.routeName),
            child: Icon(Icons.add),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
