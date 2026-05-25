import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:edusync_app/feature/admin/student/widgets/subject_header.dart';
import 'package:flutter/material.dart';

import '../../student/model/subject_model.dart';

class AssignSubject extends StatefulWidget {
  final List<SubjectModel> subjects;
  final Function(List<SubjectModel>) onChanged;
  const AssignSubject({
    super.key,
    required this.subjects,
    required this.onChanged,
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
                style: textTheme.titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
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
                items: [
                  "Software Engineering",
                  "Computer Graphics",
                  "Artificial Intelligence",
                  "Data Science",
                  "Machine Learning",
                ],
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
                    if (!widget.subjects.any(
                            (s) => s.name == selectedSubject)) {
                      final newList =
                      List<SubjectModel>.from(widget.subjects);
                      newList.add(
                        SubjectModel(
                          name: selectedSubject!,
                          code:
                          "${selectedSubject!.substring(0, 2).toUpperCase()}101",
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SubjectHeader(
            subjects: widget.subjects,
            onDelete: (index) {
              final newList =
              List<SubjectModel>.from(widget.subjects);
              newList.removeAt(index);
              widget.onChanged(newList);
            },
          ),
        ),
      ],
    );
  }
}