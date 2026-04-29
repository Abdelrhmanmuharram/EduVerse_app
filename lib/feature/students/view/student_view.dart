import 'package:flutter/material.dart';

class StudentView extends StatelessWidget {
  static const String routeName = '/student';

  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:  Text("Student View")),
    );
  }
}
