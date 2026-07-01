import '../../../admin/departments/model/department_model.dart';

class StudentSubjectModel {
  final int id;
  final String code;
  final String subjectName;
  final int yearId;
  final int semesterId;
  final int departmentId;
  final DepartmentModel department;

  const StudentSubjectModel({
    required this.id,
    required this.code,
    required this.subjectName,
    required this.yearId,
    required this.semesterId,
    required this.departmentId,
    required this.department,
  });

  factory StudentSubjectModel.fromJson(Map<String, dynamic> json) {
    return StudentSubjectModel(
      id: json['id'],
      code: json['code'],
      subjectName: json['engName'],
      yearId: json['yearId'],
      semesterId: json['semesterId'],
      departmentId: json['departmentId'],
      department: DepartmentModel.fromJson(json['department']),
    );
  }
}
