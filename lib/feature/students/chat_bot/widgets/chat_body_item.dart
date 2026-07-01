import 'package:edusync_app/feature/students/chat_bot/widgets/typing_indicator_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../model/chat_message_model.dart';
import 'chat_message_item.dart';

class ChatBodyItem extends StatelessWidget {
  final List<ChatMessageModel> messages;
  final ScrollController scrollController;
  final bool isTyping;
  const ChatBodyItem({
    super.key,
    required this.messages,
    required this.scrollController,
    required this.isTyping,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.hintText.withOpacity(.3)),
      ),
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length + (isTyping ? 1 : 0),
        itemBuilder: (_, index) {
          if (index == messages.length) {
            return const Padding(
              padding: EdgeInsets.only(top: 12),
              child: TypingIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ChatMessageItem(message: messages[index]),
          );
        },
      ),
    );
  }
}
