import 'package:flutter/material.dart';

class MaterialDropItem extends StatelessWidget {
  final String title;
  final bool selected;

  const MaterialDropItem ({super.key, required this.title, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xffF5F7FB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Checkbox(value: selected, onChanged: (_) {}),
          const SizedBox(width: 6),
          Expanded(child: Text(title)),
        ],
      ),
    );
  }
}
