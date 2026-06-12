import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:edusync_app/feature/admin/instructors/model/instructor_subject_model.dart';
import 'package:edusync_app/feature/admin/student/widgets/subject_header.dart';
import 'package:flutter/material.dart';

import '../../student/model/subject_model.dart';

class AssignSubject extends StatefulWidget {
  final List<InstructorSubjectModel> subjects;
  final List<SubjectModel> allSubjects;
  final Function(List<InstructorSubjectModel>) onChanged;

  const AssignSubject({
    super.key,
    required this.subjects,
    required this.onChanged,
    required this.allSubjects,
  });

  @override
  State<AssignSubject> createState() => _AssignSubjectState();
}

class _AssignSubjectState extends State<AssignSubject> {
  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Assign Subjects',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.primaryLight.withOpacity(.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${widget.subjects.length} Selected',
                style: textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: DefaultDropDownField(
                items: widget.allSubjects
                    .map((subject) => subject.name)
                    .toList(),
                hint: selectedSubject ?? 'Select Subject',
                icon: 'department',
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  color: AppTheme.white,
                  icon: const Icon(Icons.add),
                  onPressed: selectedSubject == null
                      ? null
                      : () {
                    final alreadyAdded = widget.subjects.any(
                          (s) => s.subject.name == selectedSubject,
                    );
                    if (!alreadyAdded) {
                      final newList =
                      List<InstructorSubjectModel>.from(widget.subjects);
                      final subject = widget.allSubjects.firstWhere(
                            (s) => s.name == selectedSubject,
                      );
                      newList.add(
                        InstructorSubjectModel(
                          id: 0,
                          instructorId: '',
                          subjectId: subject.id,
                          subject: subject,
                        ),
                      );
                      widget.onChanged(newList);
                      setState(() {
                        selectedSubject = null;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SubjectHeader(
            subjects: widget.subjects,
            onDelete: (index) {
              final newList =
              List<InstructorSubjectModel>.from(widget.subjects);
              newList.removeAt(index);
              widget.onChanged(newList);
            },
          ),
        ),
      ],
    );
  }
}