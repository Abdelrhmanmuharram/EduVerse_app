import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/back_item.dart';
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

  late SemesterModel semester;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      semester = ModalRoute.of(context)!.settings.arguments as SemesterModel;
      arabicNameController.text = semester.arabicName;
      englishNameController.text = semester.englishName;
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TitleWidget(title: 'Edit Semester'),
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
              PrimaryButton(
                label: 'Edit',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (arabicNameController.text.trim() ==
                            semester.arabicName &&
                        englishNameController.text.trim() ==
                            semester.englishName) {
                      Navigator.pop(context);
                      return;
                    }
                    Navigator.pop(
                      context,
                      SemesterModel(
                        id: semester.id,
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
