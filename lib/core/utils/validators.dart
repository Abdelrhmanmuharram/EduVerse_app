class AppValidators {
  static final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,4}$',
  );
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty || value.length < 3) {
      return '$fieldName is required';
    }
    return null;
  }
}
