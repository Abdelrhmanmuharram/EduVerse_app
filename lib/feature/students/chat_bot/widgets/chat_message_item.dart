import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../model/chat_message_model.dart';

class ChatMessageItem extends StatelessWidget {
  final ChatMessageModel message;
  const ChatMessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final isUser = message.isUser;
    return Row(
      mainAxisAlignment: isUser ? .end : .start,
      crossAxisAlignment: isUser ? .end : .start,
      children: [
        isUser
            ? const SizedBox.shrink()
            : const Icon(
                Icons.auto_awesome,
                color: AppTheme.primaryLight,
                size: 20,
              ),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: isUser ? const Color(0xffF5F7FB) : AppTheme.primaryLight,
              borderRadius: isUser
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
              border: Border.all(color: AppTheme.hintText.withOpacity(.3)),
            ),
            child: Text(
              message.message,
              style: textTheme.titleMedium!.copyWith(
                color: isUser ? AppTheme.black : AppTheme.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
