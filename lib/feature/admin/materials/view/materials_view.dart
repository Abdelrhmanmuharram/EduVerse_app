import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/primary_button.dart';
import 'package:edusync_app/core/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../view_model/materials_admin_view_model.dart';
import '../widgets/materials_table.dart';

class MaterialsAdminView extends StatelessWidget {
  static const String routeName = '/materials-admin';
  const MaterialsAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MaterialAdminViewModel>();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: TitleWidget(title: 'Materials'),
            centerTitle: true,
            leading: BackItem(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: DefaultTextField(
                        hint: 'Search by title, subject, or instructor',
                        onChanged: (value) {
                          context
                              .read<MaterialAdminViewModel>()
                              .searchMaterials(value);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: PrimaryButton(label: 'Add', onPressed: () {}),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                MaterialsTable(),
              ],
            ),
          ),
        ),
        if (viewModel.isDownloading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(child: LoadingWidget()),
          ),
      ],
    );
  }
}
