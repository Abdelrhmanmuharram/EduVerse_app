import '../../../years/model/year_model.dart';
import '../../departments/model/department_model.dart';
import '../../semesters/model/semester_model.dart';

class SubjectsModel {
  final int id;
  final String code;
  final String arbName;
  final String engName;
  final int yearId;
  final int semesterId;
  final int departmentId;
  final YearModel? year;
  final SemesterModel? semester;
  final DepartmentModel? department;

  SubjectsModel({
    required this.id,
    required this.code,
    required this.arbName,
    required this.engName,
    required this.yearId,
    required this.semesterId,
    required this.departmentId,
    this.year,
    this.semester,
    this.department,
  });

  factory SubjectsModel.fromJson(Map<String, dynamic> json) {
    return SubjectsModel(
      id: json['id'],
      code: json['code'],
      arbName: json['arbName'],
      engName: json['engName'],
      yearId: json['yearId'],
      semesterId: json['semesterId'],
      departmentId: json['departmentId'],
      year: json['year'] != null ? YearModel.fromJson(json['year']) : null,
      semester: json['semester'] != null
          ? SemesterModel.fromJson(json['semester'])
          : null,
      department: json['department'] != null
          ? DepartmentModel.fromJson(json['department'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'arbName': arbName,
      'engName': engName,
      'yearId': yearId,
      'semesterId': semesterId,
      'departmentId': departmentId,
    };
  }
}
