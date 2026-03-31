import 'package:flutter/material.dart';

class StudentsFooter extends StatelessWidget {
  final int currentPage;

  const StudentsFooter({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: currentPage == 0,
          child: const Text("‹ Prev", style: TextStyle(color: Colors.grey)),
        ),

        Row(
          children: List.generate(currentPage, (index) {
            final page = index + 1;
            final isActive = page == currentPage;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isActive ? Colors.blue : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Text(
                "$page",
                style: TextStyle(color: isActive ? Colors.white : Colors.grey),
              ),
            );
          }),
        ),

        const Text("Next ›", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
