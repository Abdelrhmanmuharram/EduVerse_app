class StudentInstructorModel {
  final String id;
  final String fullName;
  final String email;
  final String? imageUrl;

  const StudentInstructorModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.imageUrl,
  });

  factory StudentInstructorModel.fromJson(Map<String, dynamic> json) {
    return StudentInstructorModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }
}