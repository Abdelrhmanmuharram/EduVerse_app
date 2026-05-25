import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/feature/admin/student/model/student_model.dart';
import 'package:flutter/material.dart';

class StudentTableBody extends StatelessWidget {
  final List<Student> students;
  final Function(Student)? onRowTap;

  const StudentTableBody({super.key, required this.students,this.onRowTap});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12, bottom: 12, top: 12),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "#",
                  style: textTheme.titleSmall!.copyWith(
                    fontSize: 11,
                    color: AppTheme.secondText,
                    fontWeight: .w600,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "CODE",
                  style: textTheme.titleSmall!.copyWith(
                    fontSize: 11,
                    fontWeight: .w600,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "NAME",
                  style: textTheme.titleSmall!.copyWith(
                    fontSize: 11,
                    color: AppTheme.secondText,
                    fontWeight: .w600,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "DEPT",
                  style: textTheme.titleSmall!.copyWith(
                    fontSize: 11,
                    color: AppTheme.secondText,
                    fontWeight: .w600,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "YEAR",
                  style: textTheme.titleSmall!.copyWith(
                    fontSize: 11,
                    color: AppTheme.secondText,
                    fontWeight: .w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...List.generate(students.length, (index) {
          final student = students[index];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: index.isEven ? Colors.white : const Color(0xffF4F6FA),
              border: Border(bottom: BorderSide(color: Color(0xffEEEEEE))),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: () => onRowTap?.call(student),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "0${index + 1}",
                        style: textTheme.titleSmall!.copyWith(
                          fontSize: 14,
                          color: AppTheme.secondText,
                          fontWeight: .w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        student.code,
                        style: TextStyle(fontWeight: .bold),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        student.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffEEF2FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          student.dept,
                          textAlign: TextAlign.center,
                          style: textTheme.titleSmall!.copyWith(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Text(
                        student.year,
                        style: textTheme.titleSmall!.copyWith(
                          color: AppTheme.secondText,
                          fontWeight: .w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
