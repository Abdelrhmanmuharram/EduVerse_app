import 'package:edusync_app/feature/admin/model/student_model.dart';

class StudentsListViewModel {

  final List<Student> students = [

    Student(
      code: "CS2023001",
      name: "Ahmed Mohamed",
      dept: "CS",
      year: "3rd",
    ),

    Student(
      code: "CS2023002",
      name: "Sara Ali",
      dept: "IT",
      year: "2nd",
    ),

    Student(
      code: "CS2023003",
      name: "Omar Khaled",
      dept: "IS",
      year: "4th",
    ),

    Student(
      code: "CS2023004",
      name: "Mona Hassan",
      dept: "CS",
      year: "1st",
    ),

  ];
}