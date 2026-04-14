class AddStudentModel {
  final String? avatar;
  final String code;
  final String firstName;
  final String lastName;
  final String arabicName;
  final String englishFullName;
  final String department;
  final String academicYear;

  AddStudentModel({
    this.avatar,
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.arabicName,
    required this.englishFullName,
    required this.department,
    required this.academicYear,
  });
}
