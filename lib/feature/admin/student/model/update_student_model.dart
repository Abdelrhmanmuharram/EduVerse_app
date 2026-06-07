class UpdateStudentModel {
  final String id;
  final String fullName;
  final String email;
  final int departmentId;
  final int yearId;


  UpdateStudentModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.departmentId,
    required this.yearId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'departmentId': departmentId,
      'yearId': yearId,
    };
  }
}
