import 'package:flutter/cupertino.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? color;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Icon(icon, size: 80,color: color,),
        const SizedBox(height: 16),
        Text(title),
      ],
    );
  }
}