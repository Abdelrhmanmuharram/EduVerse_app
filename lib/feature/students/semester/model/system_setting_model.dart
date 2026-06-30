import 'package:edusync_app/feature/admin/semesters/model/semester_model.dart';

class SystemSettingModel {
  final int id;
  final int currentSemesterId;
  final SemesterModel currentSemester;

  const SystemSettingModel({
    required this.id,
    required this.currentSemesterId,
    required this.currentSemester,
  });

  factory SystemSettingModel.fromJson(Map<String, dynamic> json) {
    return SystemSettingModel(
      id: json['id'] ?? 0,
      currentSemesterId: json['currentSemesterId'] ?? 0,
      currentSemester: SemesterModel.fromJson(json['currentSemester'] ?? {}),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currentSemesterId': currentSemesterId,
      'currentSemester': currentSemester.toJson(),
    };
  }
}
