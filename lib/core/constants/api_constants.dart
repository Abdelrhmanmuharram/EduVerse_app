class APIConstants {
  static const String baseUrl = "https://lmsnctuapi.runasp.net/api";

  static const String login = "/Auth/GetToken";
  static const String refreshToken = '/Auth/refreshToken';
  static const String addUser = "/Auth/addUser";
  static const String logout = "/Auth/Logout";
  static const String semesters = "/Semesters";
  static const String departments = '/Departments';
  static const String usersByRole = '/Users/GetUsersByRole';
  static const String years = '/Years';
  static const String updateProfile = '/Users/profile';
  static const String instructorSubjects = '/InstructorSubjects';
  static const String getInstructorSubjects =
      '/InstructorSubjects/GetInstructorSubjects';
  static const String getSubjectInstructors =
      '/InstructorSubjects/GetSubjectInstructors';
  static const String getMaterials = '/Materials';
  static const String subjects = '/Subjects';
  static const String attendancesSessions = '/AttendanceSessions';
  static const String generateAi = '/ai/generate';
  static const String attendances = '/Attendances';
  static const String dashboard = '/Dashboard/student';
  static const String instructorBySubject =
      '/InstructorSubjects/GetSubjectInstructors';
  static const String subjectMaterials = '/Materials/GetSubjectMaterials';
}
