import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../model/department_model.dart';

class EditDepartmentView extends StatefulWidget {
  static const String routeName = '/edit-department';
  const EditDepartmentView({super.key});

  @override
  State<EditDepartmentView> createState() => _EditDepartmentViewState();
}

class _EditDepartmentViewState extends State<EditDepartmentView> {
  TextEditingController arabicNameController = TextEditingController();
  TextEditingController englishNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DepartmentModel department =
        ModalRoute.of(context)!.settings.arguments as DepartmentModel;
    arabicNameController.text = department.arabicName;
    englishNameController.text = department.englishName;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Edit Department', style: textTheme.headlineSmall),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset('assets/icons/back.svg'),
        ),
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
              PrimaryButton(
                label: 'Edit',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (arabicNameController.text.trim() ==
                            department.arabicName &&
                        englishNameController.text.trim() ==
                            department.englishName) {
                      Navigator.pop(context);
                      return;
                    }
                    Navigator.pop(
                      context,
                      DepartmentModel(
                        id: department.id,
                        arabicName: arabicNameController.text,
                        englishName: englishNameController.text,
                      ),
                    );
                  }
                },
                color: AppTheme.primaryLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
