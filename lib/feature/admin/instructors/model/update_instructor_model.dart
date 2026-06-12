class UpdateInstructorModel {
  final String id;
  final String fullName;
  final String email;
  final int? departmentId;

  UpdateInstructorModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.departmentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'departmentId': departmentId,
      'yearId': null,
    };
  }
}