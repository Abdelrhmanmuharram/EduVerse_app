import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/materials_model.dart';
import 'matrial_item.dart';

class MaterialsList extends StatelessWidget {
  const MaterialsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => MaterialItem(
          material: MaterialsModel(
            title: 'Material Title',
            description: 'Material Description',
            file: File('path/to/file'),
            instructorId: 1,
            subjectId: 1,
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: 10,
      ),
    );
  }
}
