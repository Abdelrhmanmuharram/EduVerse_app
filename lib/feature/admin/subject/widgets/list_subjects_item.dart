import 'package:flutter/cupertino.dart';
import '../model/subjects_model.dart';
import 'subjects_item.dart';

class ListSubjectItem extends StatefulWidget {
  final List<SubjectsModel> subjects;
  final Function(SubjectsModel) onDelete;
  final Function(SubjectsModel, int) onEdit;
  const ListSubjectItem({
    super.key,
    required this.subjects,
    required this.onDelete,
    required this.onEdit,
  });
  @override
  State<ListSubjectItem> createState() => _ListSubjectsItemState();
}

class _ListSubjectsItemState extends State<ListSubjectItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => SubjectsItem(
        subjects: widget.subjects[index],
        onDelete: () {
          widget.onDelete(widget.subjects[index]);
        },

        onEdit: () {
          widget.onEdit(widget.subjects[index], index);
        },
      ),
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemCount: widget.subjects.length,
    );
  }
}
