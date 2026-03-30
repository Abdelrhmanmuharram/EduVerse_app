import 'package:flutter/material.dart';
import '../app_theme.dart';

class UmsNavItem {
  final IconData icon;
  final String label;
  const UmsNavItem({required this.icon, required this.label});
}

class UmsBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<UmsNavItem> items;

  const UmsBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final item = items[i];
              final isActive = i == currentIndex;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 22,
                        color: isActive ? AppTheme.primaryLight : AppTheme.hintText,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                          color: isActive ? AppTheme.primaryLight : AppTheme.hintText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (isActive)
                        Container(
                          width: 18,
                          height: 3,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryLight,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )
                      else
                        const SizedBox(height: 3),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
