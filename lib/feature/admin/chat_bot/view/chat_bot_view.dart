import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../subject/view_model/subject_view_model.dart';
import '../view_model/ai_view_model.dart';

class ChatBotView extends StatelessWidget {
  static const String routeName = '/chat-bot';
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectsViewModel = context.watch<SubjectsViewModel>();
    final aiViewModel = context.watch<AiViewModel>();
    return Scaffold(
      appBar: AppBar(title: TitleWidget(title: 'Chat Bot')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DefaultDropDownField(
              selectedItem: aiViewModel.selectedSubjectName,
              items: subjectsViewModel.subjects.map((e) => e.engName).toList(),
              hint: 'Select Subject',
              icon: 'subject',
              onChanged: (value) async {
                final subject = subjectsViewModel.subjects.firstWhere(
                    (e) => e.engName == value,
                );
                await aiViewModel.selectSubject(
                  subjectId: subject.id,
                  subjectName: subject.engName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
