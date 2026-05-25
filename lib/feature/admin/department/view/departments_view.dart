import 'package:flutter/material.dart';

class DepartmentsView extends StatelessWidget {
  static const String routeName = '/departments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Departments'),
        centerTitle: true,
      ),
    );
  }
}
