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
}