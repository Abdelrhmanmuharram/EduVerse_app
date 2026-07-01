import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import 'material_drop_item.dart';

class ChatContextCard extends StatefulWidget {
  const ChatContextCard({super.key});

  @override
  State<ChatContextCard> createState() => _ChatContextCardState();
}

class _ChatContextCardState extends State<ChatContextCard>
    with TickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.hintText.withOpacity(.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: AppTheme.primaryLight,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "Context",
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                AnimatedRotation(
                  turns: _isExpanded ? 0 : 0.5,
                  duration: const Duration(milliseconds: 250),
                  child: const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: AppTheme.primaryLight,
                  ),
                ),
              ],
            ),
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _isExpanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 22),

                      Text(
                        "SELECT SUBJECT",
                        style: textTheme.labelSmall?.copyWith(
                          color: AppTheme.secondText,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DefaultDropDownField(
                        items: ['Quiz', 'Lecture 3', 'Lecture 1'],
                        hint: 'Select Subject',
                        icon: 'subject',
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "MATERIALS",
                        style: textTheme.labelSmall?.copyWith(
                          color: AppTheme.secondText,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MaterialDropItem(title: "Quiz", selected: true),
                      const SizedBox(height: 8),
                      MaterialDropItem(title: "Lecture 3", selected: false),
                      const SizedBox(height: 8),
                      MaterialDropItem(title: "Lecture 1", selected: false),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
