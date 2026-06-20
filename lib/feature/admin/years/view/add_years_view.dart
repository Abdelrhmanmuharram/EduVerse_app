import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../../years/model/year_model.dart';
import '../../../years/viewmodel/year_viewmodel.dart';

class AddYearsView extends StatefulWidget {
  static const String routeName = '/add-years';
  const AddYearsView({super.key});

  @override
  State<AddYearsView> createState() => _AddYearsViewState();
}

class _AddYearsViewState extends State<AddYearsView> {
  final arabicNameController = TextEditingController();
  final englishNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    arabicNameController.dispose();
    englishNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<YearViewmodel>();
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: TitleWidget(title: 'Add Years'),
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
                    hint: 'Arabic Name',
                    controller: arabicNameController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Arabic Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DefaultTextField(
                    hint: 'English Name',
                    controller: englishNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'English Name is required';
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  PrimaryButton(
                    label: viewModel.isLoading ? 'Saving...' : 'Save',
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      final year = YearModel(
                        id: 0,
                        arbName: arabicNameController.text.trim(),
                        engName: englishNameController.text.trim(),
                      );
                      await context.read<YearViewmodel>().addYears(year);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Year added successfully'),
                            backgroundColor: AppTheme.green,
                          ),
                        );
                        Navigator.pop(context, true);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        if (viewModel.isLoading) Container(
          color: Colors.black.withValues(alpha: 0.4),
          child: const Center(child: LoadingWidget()),
        ),
      ],
    );
  }
}
