import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../model/semester_model.dart';

class EditSemesterView extends StatefulWidget {
  static const String routeName = '/edit-semester';
  const EditSemesterView({super.key});

  @override
  State<EditSemesterView> createState() => _EditSemesterViewState();
}

class _EditSemesterViewState extends State<EditSemesterView> {
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final SemesterModel semester =
    ModalRoute.of(context)!.settings.arguments as SemesterModel;
    arabicNameController.text = semester.arabicName;
    englishNameController.text = semester.englishName;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Semester', style: textTheme.headlineSmall),
        centerTitle: true,
        leading: SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              DefaultTextField(
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    AppValidators.requiredField(value, 'Arabic Name'),
                controller: arabicNameController,
                hint: 'Enter Arabic Name',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/language.svg',
                  width: 24,
                  height: 24,
                  fit: .scaleDown,
                ),
              ),
              SizedBox(height: 12),
              DefaultTextField(
                textInputAction: TextInputAction.done,
                validator: (value) =>
                    AppValidators.requiredField(value, 'English Name'),
                controller: englishNameController,
                hint: 'Enter English Name',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/language.svg',
                  width: 24,
                  height: 24,
                  fit: .scaleDown,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Back',
                      onPressed: () => Navigator.pop(context),
                      color: AppTheme.black,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Edit',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pop(
                            context,
                            SemesterModel(
                              arabicName: arabicNameController.text,
                              englishName: englishNameController.text,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
