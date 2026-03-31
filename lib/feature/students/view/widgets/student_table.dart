import 'package:edusync_app/feature/students/model/student_model.dart';
import 'package:edusync_app/feature/students/view/widgets/students_header_table.dart';
import 'package:flutter/material.dart';
import 'student_table_body.dart';
import 'students_footer.dart';

class StudentTable extends StatelessWidget {
  final List<Student> students;

  const StudentTable({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF8F9FB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffE5E7EB)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: StudentsHeaderTable(total: students.length),
          ),
          StudentTableBody(students: students),
          const Padding(
            padding: EdgeInsets.all(16),
            child: StudentsFooter(currentPage: 1),
          ),
        ],
      ),
    );
  }
}
