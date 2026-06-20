import 'package:flutter/material.dart';
import '../model/menu_item_model.dart';
import 'package:edusync_app/core/enums/menu_type.dart';

class PanelViewModel {
  final List<MenuItem> menuItems = [
    MenuItem(type: MenuType.semesters),
    MenuItem(type: MenuType.departments),
    MenuItem(type: MenuType.students),
    MenuItem(type: MenuType.instructors),
    MenuItem(type: MenuType.years),
    MenuItem(type: MenuType.subjects),
  ];

  void onItemClicked(BuildContext context, MenuItem item) {
    Navigator.pushNamed(context, item.type.route);
  }
}
