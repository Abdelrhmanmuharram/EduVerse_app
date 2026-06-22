import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/widgets/back_item.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/subject_view_model.dart';
import '../widgets/list_subjects_item.dart';
import '../widgets/subjects_table.dart';
import 'add_subjects.dart';

class SubjectsView extends StatelessWidget {
  static const routeName = '/subjects';
  const SubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleWidget(title: 'Subjects'),
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
                    hint: 'Search by Code, Name, or Department',
                    prefixIcon: Icon(Icons.search, color: AppTheme.hintText),
                    onChanged: (value) {
                      context.read<SubjectsViewModel>().searchSubjects(value);
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: PrimaryButton(
                    label: 'Add',
                    onPressed: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        AddSubjects.routeName,
                      );
                      if (result == true) {
                        await context.read<SubjectsViewModel>().loadSubjects();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Subject added successfully'),
                              backgroundColor: AppTheme.green,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SubjectsTable(),
          ],
        ),
      ),
    );
  }
}
