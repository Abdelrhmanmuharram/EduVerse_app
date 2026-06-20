import 'package:flutter/cupertino.dart';
import '../../../years/model/year_model.dart';
import 'year_item.dart';

class ListYearItem extends StatefulWidget {
  final List<YearModel> year;
  final Function(YearModel) onDelete;
  final Function(YearModel, int) onEdit;
  const ListYearItem({
    super.key,
    required this.year,
    required this.onDelete,
    required this.onEdit,
  });
  @override
  State<ListYearItem> createState() => _ListYearItemState();
}

class _ListYearItemState extends State<ListYearItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => YearItem(
        year: widget.year[index],
        onDelete: () {
          widget.onDelete(widget.year[index]);
        },
        onEdit: () {
          widget.onEdit(widget.year[index], index);
        },
      ),
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemCount: widget.year.length,
    );
  }
}
