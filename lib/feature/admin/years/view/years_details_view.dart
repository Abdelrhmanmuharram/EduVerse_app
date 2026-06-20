import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../../years/model/year_model.dart';
import '../../../years/viewmodel/year_viewmodel.dart';

class YearsDetailsView extends StatefulWidget {
  static const String routeName = '/years-details';
  const YearsDetailsView({super.key});

  @override
  State<YearsDetailsView> createState() => _YearsDetailsViewState();
}

class _YearsDetailsViewState extends State<YearsDetailsView> {
  final arabicNameController = TextEditingController();
  final englishNameController = TextEditingController();
  final searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late YearModel year;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      year = ModalRoute.of(context)!.settings.arguments as YearModel;
      arabicNameController.text = year.arbName;
      englishNameController.text = year.engName;
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

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
            title: TitleWidget(title: 'Edit Years'),
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
                      if (arabicNameController.text.trim() == year.arbName &&
                          englishNameController.text.trim() == year.engName) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No changes were made'),
                            backgroundColor: AppTheme.blueGray,
                          ),
                        );
                        return;
                      }
                      final updatedYear = YearModel(
                        id: year.id,
                        arbName: arabicNameController.text.trim(),
                        engName: englishNameController.text.trim(),
                      );
                      await context.read<YearViewmodel>().updateYears(year.id, updatedYear);
                      if (context.mounted) {
                        Navigator.pop(context, true);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        if (viewModel.isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.4),
            child: const Center(child: LoadingWidget()),
          ),
      ],
    );
  }
}
