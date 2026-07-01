import 'package:flutter/material.dart';
import '../../../../core/widgets/title_widget.dart';
import '../model/chat_message_model.dart';
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
  bool _isTyping = false;

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

  final List<ChatMessageModel> messages = [
    const ChatMessageModel(
      message:
          "👋 Hi Mohammed! Select your course materials and ask me anything about them.",
      isUser: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
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
                  messages: messages,
                  scrollController: scrollController,
                  isTyping: _isTyping,
                ),
              ),
              const SizedBox(height: 8),
              ChatInputItem(controller: controller, onSend: sendMessage),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add(ChatMessageModel(message: text, isUser: true));
      _isTyping = true;
    });
    controller.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isTyping = false;
      messages.add(
        const ChatMessageModel(
          message: "This is AI Response 🤖",
          isUser: false,
        ),
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}
