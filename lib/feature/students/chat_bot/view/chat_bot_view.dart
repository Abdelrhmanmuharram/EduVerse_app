import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/title_widget.dart';
import '../model/chat_message_model.dart';
import '../view_model/student_chat_bot_view_model.dart';
import '../widgets/chat_body_item.dart';
import '../widgets/chat_context_card.dart';
import '../widgets/chat_input_item.dart';

class StudentChatBotView extends StatefulWidget {
  static const routeName = "/student-chat-bot";

  const StudentChatBotView({super.key});

  @override
  State<StudentChatBotView> createState() => _StudentChatBotViewState();
}

class _StudentChatBotViewState extends State<StudentChatBotView> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StudentChatBotViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const TitleWidget(title: "AI Student Assistant"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ChatContextCard(),
              const SizedBox(height: 16),
              Expanded(
                child: ChatBodyItem(
                  messages: vm.messages,
                  scrollController: scrollController,
                  isTyping: vm.isTyping,
                ),
              ),
              const SizedBox(height: 8),
              ChatInputItem(
                controller: controller,
                onSend: () async {
                  try {
                    final success = await vm.sendMessage(controller.text);
                    if (success) {
                      controller.clear();
                    }
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!scrollController.hasClients) return;
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString().replaceFirst("Exception: ", ""),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
