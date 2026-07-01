import 'dart:io';

class MaterialsModel {
  final File file;
  final String instructorId;
  final int subjectId;
  final String title;
  final String description;

  const MaterialsModel({
    required this.title,
    required this.description,
    required this.file,
    required this.instructorId,
    required this.subjectId,
  });
}
