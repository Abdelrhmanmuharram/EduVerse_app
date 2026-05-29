import 'package:edusync_app/core/utils/validators.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/feature/admin/departments/model/department_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/primary_button.dart';

class AddDepartmentView extends StatefulWidget {
  static const String routeName = '/add-department';
  const AddDepartmentView({super.key});

  @override
  State<AddDepartmentView> createState() => _AddDepartmentViewState();
}

class _AddDepartmentViewState extends State<AddDepartmentView> {
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Department', style: textTheme.headlineSmall),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              DefaultTextField(
                controller: arabicNameController,
                validator: (value) =>
                    AppValidators.requiredField(value, 'Arabic Name'),
                hint: 'Arabic Name',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/language.svg',
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(height: 16),
              DefaultTextField(
                controller: englishNameController,
                validator: (value) =>
                    AppValidators.requiredField(value, 'English Name'),
                hint: 'English Name',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/language.svg',
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
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
                  SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: PrimaryButton(
                      label: 'Save',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pop(
                            context,
                            DepartmentModel(
                              arabicName: arabicNameController.text,
                              englishName: englishNameController.text,
                            ),
                          );
                        }
                      },
                      color: AppTheme.primaryLight,
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
