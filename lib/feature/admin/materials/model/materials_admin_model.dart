import '../../subject/model/subjects_model.dart';
import '../../instructors/model/instructor_model.dart';

class MaterialsAdminModel {
  final int id;
  final String title;
  final String? description;
  final String filePath;
  final String publicId;
  final int subjectId;
  final String instructorId;

  final SubjectsModel subject;
  final InstructorsModel instructor;

  MaterialsAdminModel({
    required this.id,
    required this.title,
    this.description,
    required this.filePath,
    required this.publicId,
    required this.subjectId,
    required this.instructorId,
    required this.subject,
    required this.instructor,
  });

  factory MaterialsAdminModel.fromJson(Map<String, dynamic> json) {
    return MaterialsAdminModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      filePath: json['filePath'],
      publicId: json['publicId'],
      subjectId: json['subjectId'],
      instructorId: json['instructorId'],
      subject: SubjectsModel.fromJson(json['subject']),
      instructor: InstructorsModel.fromJson(json['instructor']),
    );
  }
}