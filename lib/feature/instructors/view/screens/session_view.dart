import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:edusync_app/feature/instructors/view/widgets/instructor_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/back_item.dart';
import '../../viewmodel/attendance_session_view_model.dart';
import 'attendance_session_add_update_view.dart';

class SessionView extends StatefulWidget {
  static const String routeName = '/session';
  const SessionView({super.key});

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AttendanceSessionViewModel>().loadAttendanceSessions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(title: 'Sessions'),
        centerTitle: true,
        leading: BackItem(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DefaultTextField(
                    hint: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PrimaryButton(
                    label: 'Add',
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AttendanceSessionAddUpdateView.routeName,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            InstructorTable(),
          ],
        ),
      ),
    );
  }
}
