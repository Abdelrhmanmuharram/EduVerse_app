import 'package:edusync_app/core/widgets/back_item.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
