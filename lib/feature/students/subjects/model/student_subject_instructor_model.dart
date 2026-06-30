class StudentSubjectInstructorModel {
  final String instructorId;
  final String fullName;
  final int subjectId;

  const StudentSubjectInstructorModel({
    required this.instructorId,
    required this.fullName,
    required this.subjectId,
  });

  factory StudentSubjectInstructorModel.fromJson(Map<String, dynamic> json) {
    return StudentSubjectInstructorModel(
      instructorId: json['instructorId'] ?? '',
      subjectId: json['subjectId'] ?? 0,
      fullName: json['instructor']?['fullName'] ?? '',
    );
  }
}
