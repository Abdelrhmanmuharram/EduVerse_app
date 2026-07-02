import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:edusync_app/feature/instructors/view/widgets/session_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/back_item.dart';
import '../../viewmodel/attendance_session_view_model.dart';

class SessionAttendanceView extends StatelessWidget {
  static const String routeName = '/session-attendance';

  final String sessionId;

  const SessionAttendanceView({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AttendanceSessionViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(title: 'Session Attendance'),
        centerTitle: true,
        leading: BackItem(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DefaultTextField(
              hint: 'Search',
              onChanged: viewModel.search,

            ),
            const SizedBox(height: 10),
            SessionTable(sessionId: sessionId),
          ],
        ),
      ),
    );
  }
}
