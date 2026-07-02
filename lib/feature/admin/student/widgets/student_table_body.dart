import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/feature/admin/student/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/student_viewmodel.dart';

class StudentTableBody extends StatelessWidget {
  final List<Student> students;
  final Function(Student)? onRowTap;

  const StudentTableBody({super.key, required this.students, this.onRowTap});
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
              Expanded(
                flex: 2,
                child: Text(
                  "ACTIONS",
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
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Delete Student"),
                                  content: const Text(
                                    "Are you sure you want to delete this student?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: AppTheme.primaryLight,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(color: AppTheme.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm != true) return;

                              try {
                                await context
                                    .read<StudentViewModel>()
                                    .deleteStudent(student.id);

                                if (!context.mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Student deleted successfully",
                                    ),
                                  ),
                                );
                              } catch (e) {
                                if (!context.mounted) return;
                                String message = e.toString().replaceFirst(
                                  "Exception: ",
                                  "",
                                );

                                switch (message) {
                                  case "NotDeletedMessage":
                                    message =
                                        "This student cannot be deleted because they are linked to existing data.";
                                    break;

                                  case "NotDeactivatedMessage":
                                    message =
                                        "This account cannot be deactivated at the moment.";
                                    break;

                                  case "NotReactivatedMessage":
                                    message =
                                        "This account cannot be reactivated at the moment.";
                                    break;

                                  default:
                                    if (message.contains("SocketException")) {
                                      message =
                                          "No internet connection. Please check your network and try again.";
                                    } else if (message.contains(
                                      "TimeoutException",
                                    )) {
                                      message =
                                          "The request took too long. Please try again.";
                                    } else if (message.contains("500")) {
                                      message =
                                          "Something went wrong. Please try again later.";
                                    }
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(message),
                                  ),
                                );
                              }
                            },
                            child: const Icon(
                              Icons.delete,
                              color: AppTheme.red,
                            ),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () async {
                              if (student.isActive) {
                                await context
                                    .read<StudentViewModel>()
                                    .deactivateStudent(student.id);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: AppTheme.primaryLight,
                                    content: Text(
                                      "Student deactivated successfully",
                                    ),
                                  ),
                                );
                              } else {
                                await context
                                    .read<StudentViewModel>()
                                    .reactivateStudent(student.id);

                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: AppTheme.green,
                                    content: Text(
                                      "Student reactivated successfully",
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Icon(
                              student.isActive ? Icons.lock : Icons.lock_open,
                              color: student.isActive
                                  ? AppTheme.red
                                  : Colors.green,
                            ),
                          ),
                        ],
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
