import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/back_item.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../viewmodel/materials_viewmodel.dart';
import '../widgets/materials_list.dart';

class MaterialsView extends StatefulWidget {
  static const String routeName = '/materials';
  const MaterialsView({super.key});

  @override
  State<MaterialsView> createState() => _MaterialsViewState();
}

class _MaterialsViewState extends State<MaterialsView> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MaterialsViewModel>().loadMaterials();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final vm = context.watch<MaterialsViewModel>();
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
                    controller: searchController,
                    onChanged: vm.search,
                    hint: 'Search materials',
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
                    onPressed: () =>
                        Navigator.pushNamed(context, '/material-add'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (vm.isLoading)
              const Expanded(child: Center(child: LoadingWidget()))
            else if (vm.errorMessage != null)
              Expanded(child: Center(child: Text(vm.errorMessage!)))
            else if (vm.filteredMaterials.isEmpty)
              const Expanded(child: Center(child: Text("No materials found")))
            else
              const MaterialsList(),
          ],
        ),
      ),
    );
  }
}

