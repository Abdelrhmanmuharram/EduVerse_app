import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';

class ChatInputItem extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;

  const ChatInputItem({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: DefaultTextField(
            hint: 'Type your message...',
            readOnly: isLoading,
            controller: controller,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) {
              if (!isLoading) {
                onSend();
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: PrimaryButton(
            label: 'Ask',
            onPressed: isLoading ? null : onSend,
            icon: Icons.send,
          ),
        ),
      ],
    );
  }
}
