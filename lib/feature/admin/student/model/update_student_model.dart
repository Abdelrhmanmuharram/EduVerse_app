class UpdateStudentModel {
  final String id;
  final String fullName;
  final int departmentId;

  UpdateStudentModel({
    required this.id,
    required this.fullName,
    required this.departmentId,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'fullName': fullName, 'departmentId': departmentId};
  }
}
