import 'package:edusync_app/feature/admin/student/model/subject_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../instructors/model/instructor_subject_model.dart';

class SubjectHeader extends StatelessWidget {
  final List<InstructorSubjectModel> subjects;
  final Function(int) onDelete;

  const SubjectHeader({
    super.key,
    required this.subjects,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SUBJECT",
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.hintText,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    "CODE",
                    style: textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.hintText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          subjects.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "No subjects assigned",
                    style: textTheme.titleSmall,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    return Column(
                      children: [
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  subject.subject.name,
                                  style: textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.black,
                                  ),
                                ),
                              ),
                              Text(
                                subject.subject.code,
                                style: textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () => onDelete(index),
                                child: const Icon(
                                  Icons.delete,
                                  color: AppTheme.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Assigned teachers for this session will appear here",
              style: textTheme.titleSmall!.copyWith(color: AppTheme.hintText),
            ),
          ),
        ],
      ),
    );
  }
}
