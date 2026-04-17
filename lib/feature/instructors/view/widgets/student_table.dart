import 'package:edusync_app/feature/admin/model/student_model.dart';
import 'package:edusync_app/feature/admin/view/widgets/students_header_table.dart';
import 'package:flutter/material.dart';
import 'student_table_body.dart';
import 'students_footer.dart';

class StudentTable extends StatefulWidget {
  final List<Student> students;
  final Function(Student)? onRowTap;

  const StudentTable({super.key, required this.students,this.onRowTap});

  @override
  State<StudentTable> createState() => _StudentTableState();
}

class _StudentTableState extends State<StudentTable> {

  int currentPage = 1;
  int itemsPerPage = 6;
  int get availablePages => (widget.students.length / itemsPerPage).ceil();
  @override
  Widget build(BuildContext context) {
    int start = (currentPage - 1) * itemsPerPage;
    int end = start + itemsPerPage;

    List<Student> currentStudents = widget.students.sublist(
      start,
      end > widget.students.length ? widget.students.length : end,
    );
    return Column(
      children: [
        StudentsHeaderTable(total: widget.students.length),
        StudentTableBody(students: currentStudents, onRowTap: widget.onRowTap ),
        StudentsFooter(
          currentPage: currentPage,
          totalPages: availablePages,
          availablePages: availablePages,
          onPageChanged: (page) {
            setState(() {
              currentPage = page;
            });
          },
        ),
      ],
    );
  }
}
