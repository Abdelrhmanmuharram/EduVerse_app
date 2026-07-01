import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/materials_model.dart';
import '../../viewmodel/materials_viewmodel.dart';
import 'matrial_item.dart';

class MaterialsList extends StatelessWidget {
  const MaterialsList({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MaterialsViewModel>();

    return Expanded(
      child: ListView.separated(
        itemCount: vm.filteredMaterials.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (_, index) {
          return MaterialItem(material: vm.filteredMaterials[index]);
        },
      ),
    );
  }
}
