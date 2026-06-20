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
  final YearModel year;
  final SemesterModel semester;
  final DepartmentModel department;

  SubjectsModel({
    required this.id,
    required this.code,
    required this.arbName,
    required this.engName,
    required this.yearId,
    required this.semesterId,
    required this.departmentId,
    required this.year,
    required this.semester,
    required this.department,
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
      year: YearModel.fromJson(json['year']),
      semester: SemesterModel.fromJson(json['semester']),
      department: DepartmentModel.fromJson(json['department']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'arbName': arbName,
      'engName': engName,
      'yearId': yearId,
      'semesterId': semesterId,
      'departmentId': departmentId,
    };
  }
}
