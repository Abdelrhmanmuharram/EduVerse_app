import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';

class MaterialDropItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const MaterialDropItem({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffF5F7FB),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            IgnorePointer(
              child: Checkbox(
                value: selected,
                activeColor: AppTheme.primaryLight,
                checkColor: Colors.white,
                side: BorderSide(
                  color: AppTheme.primaryLight,
                  width: 1.8,
                ),
                onChanged: (_) {},
              )
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}