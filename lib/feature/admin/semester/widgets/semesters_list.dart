import 'package:edusync_app/feature/admin/semester/widgets/semester_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/semester_model.dart';

class SemestersList extends StatefulWidget {
  final List<SemesterModel> semesters;
  final Function(SemesterModel) onDelete;
  final Function(SemesterModel, int) onEdit;
  const SemestersList({
    super.key,
    required this.semesters,
    required this.onDelete,
    required this.onEdit,
  });
  @override
  State<SemestersList> createState() => _SemestersListState();
}

class _SemestersListState extends State<SemestersList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemCount: widget.semesters.length,
      itemBuilder: (context, index) {
        return SemesterItem(
          semester: widget.semesters[index],
          onDelete: () {
            widget.onDelete(widget.semesters[index]);
          },
          onEdit: () {
            widget.onEdit(widget.semesters[index], index);
          },
        );
      },
    );
  }
}
