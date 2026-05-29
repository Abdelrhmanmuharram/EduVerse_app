import 'package:flutter/cupertino.dart';

import '../model/department_model.dart';
import 'department_item.dart';

class ListDepartmentItem extends StatefulWidget {
  final List<DepartmentModel> departments;
  final Function(DepartmentModel) onDelete;
  final Function(DepartmentModel, int) onEdit;
  const ListDepartmentItem({
    super.key,
    required this.departments,
    required this.onDelete,
    required this.onEdit,
  });
  @override
  State<ListDepartmentItem> createState() => _ListDepartmentItemState();
}

class _ListDepartmentItemState extends State<ListDepartmentItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => DepartmentItem(
        department: widget.departments[index],
        onDelete: () {
          widget.onDelete(widget.departments[index]);
        },
        onEdit: () {
          widget.onEdit(widget.departments[index], index);
        },
      ),
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemCount: widget.departments.length,
    );
  }
}
