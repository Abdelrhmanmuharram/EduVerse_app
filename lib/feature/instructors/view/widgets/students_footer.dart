import 'package:flutter/material.dart';

class StudentsFooter extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;
  final int availablePages;

  const StudentsFooter({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    required this.availablePages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          child: Text(
            "‹ Prev",
            style: TextStyle(
              color: currentPage > 1 ? Colors.black : Colors.grey,
            ),
          ),
        ),
        Row(
          children: List.generate(availablePages, (index) {
            final page = index + 1;
            final isActive = page == currentPage;
            return GestureDetector(
              onTap: () => onPageChanged(page),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$page",
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }),
        ),
        GestureDetector(
          onTap: currentPage < availablePages
              ? () => onPageChanged(currentPage + 1)
              : null,
          child: Text(
            "Next ›",
            style: TextStyle(
              color: currentPage < totalPages ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
