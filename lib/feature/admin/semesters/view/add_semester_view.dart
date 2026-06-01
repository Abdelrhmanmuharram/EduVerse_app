import 'package:edusync_app/core/utils/validators.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/feature/admin/semesters/model/semester_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/title_widget.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TitleWidget(title: 'Add Semester'),
        centerTitle: true,
        leading: BackItem(),
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
              PrimaryButton(
                label: 'Save',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(
                      context,
                      SemesterModel(
                        id: 0,
                        arabicName: arabicNameController.text,
                        englishName: englishNameController.text,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
