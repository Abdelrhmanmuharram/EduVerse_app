import 'package:edusync_app/core/utils/validators.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/feature/admin/semester/model/semester_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/primary_button.dart';

class AddSemester extends StatefulWidget {
  static const String routeName = '/add-semester';
  const AddSemester({super.key});
  @override
  State<AddSemester> createState() => _AddSemesterState();
}
class _AddSemesterState extends State<AddSemester> {
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Semester', style: textTheme.headlineSmall),
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
                hint: 'Arabic Name',
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
                hint: 'English Name',
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
                      label: 'Save',
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
