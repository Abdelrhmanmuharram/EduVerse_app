import 'package:flutter/material.dart';

enum MenuType { semesters, departments, students, instructors , years}

extension MenuTypeExtension on MenuType {
  String get route {
    switch (this) {
      case MenuType.semesters:
        return '/semesters';
      case MenuType.departments:
        return '/departments';
      case MenuType.students:
        return '/students';
      case MenuType.instructors:
        return '/instructors';
      case MenuType.years:
        return '/years';
    }
  }

  String get title {
    switch (this) {
      case MenuType.students:
        return 'Students';
      case MenuType.departments:
        return 'Departments';
      case MenuType.semesters:
        return 'Semesters';
      case MenuType.instructors:
        return 'Instructors';
      case MenuType.years:
        return 'Years';
    }
  }

  IconData get icon {
    switch (this) {
      case MenuType.students:
        return Icons.school_outlined;
      case MenuType.departments:
        return Icons.account_tree_outlined;
      case MenuType.semesters:
        return Icons.calendar_today_outlined;
      case MenuType.instructors:
        return Icons.badge_outlined;
      case MenuType.years:
        return Icons.book_outlined;
    }
  }

  String get subtitle {
    switch (this) {
      case MenuType.students:
        return 'Enrollment & records';
      case MenuType.departments:
        return 'Faculty & staff structures';
      case MenuType.semesters:
        return 'Manage academic terms';
      case MenuType.instructors:
        return 'Profiles & assignments';
      case MenuType.years:
        return 'Academic years';
    }
  }
}
