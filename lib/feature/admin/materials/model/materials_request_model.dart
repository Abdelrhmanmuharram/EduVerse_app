import 'dart:io';

class MaterialRequestModel {
  final File file;
  final String instructorId;
  final int subjectId;
  final String title;
  final String description;

  MaterialRequestModel({
    required this.file,
    required this.instructorId,
    required this.subjectId,
    required this.title,
    required this.description,
  });
}