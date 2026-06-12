import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../departments/viewmodel/departement_viewmodel.dart';
import '../model/instructor_model.dart';
import '../viewmodel/instructor_viewmodel.dart';
import '../widgets/instructor_card.dart';
import 'add_instructor_view.dart';

class AdminInstructorsView extends StatefulWidget {
  static const String routeName = '/instructors';
  const AdminInstructorsView({super.key});

  @override
  State<AdminInstructorsView> createState() => _AdminInstructorsViewState();
}

class _AdminInstructorsViewState extends State<AdminInstructorsView> {
  List<InstructorsModel> instructors = [];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final viewmodel = context.watch<InstructorViewModel>();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            'assets/icons/back.svg',
            width: 24,
            height: 24,
            fit: .scaleDown,
          ),
        ),
        title: Text('Instructors', style: textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: DefaultTextField(
                    hint: 'Search by username, code',
                    prefixIcon: Icon(Icons.search, color: AppTheme.hintText),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PrimaryButton(
                    label: 'Add',
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiProvider(
                            providers: [
                              ChangeNotifierProvider.value(
                                value: context.read<InstructorViewModel>(),
                              ),
                              ChangeNotifierProvider.value(
                                value: context.read<DepartmentViewModel>(),
                              ),
                            ],
                            child: const AddInstructorView(),
                          ),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          instructors.add(result as InstructorsModel);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            InstructorCard(instructors: viewmodel.instructors),
          ],
        ),
      ),
    );
  }
}
