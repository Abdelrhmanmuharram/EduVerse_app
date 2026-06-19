import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/materials_list.dart';

class MaterialsView extends StatelessWidget {
  static const String routeName = '/materials';
  const MaterialsView({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Materials', style: textTheme.headlineSmall),
        centerTitle: true,
        leading: BackItem(),
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
                    hint: 'Search',
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/search.svg',
                      width: 24,
                      height: 24,
                      fit: .scaleDown,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PrimaryButton(
                    label: 'Add',
                    onPressed: () => Navigator.pushNamed(context, '/material-add'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            MaterialsList()
          ],
        ),
      ),
    );
  }
}
