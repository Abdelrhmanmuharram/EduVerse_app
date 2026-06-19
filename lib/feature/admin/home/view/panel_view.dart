import 'package:edusync_app/core/enums/menu_type.dart';
import 'package:edusync_app/core/widgets/menu_item_card.dart';
import 'package:edusync_app/feature/admin/home/viewmodel/panel_viewmodel.dart';
import 'package:flutter/material.dart';

import '../widgets/admin_header_widget.dart';

class PanelView extends StatelessWidget {
  final viewModel = PanelViewModel();

  PanelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            AdminHeader(),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: viewModel.menuItems.length,
                separatorBuilder: (_, _) => SizedBox(height: 16),
                itemBuilder: (_, index) {
                  final item = viewModel.menuItems[index];
                  return GestureDetector(
                    onTap: () {
                      viewModel.onItemClicked(context, item);
                    },
                    child: MenuItemCard(
                      icon: item.type.icon,
                      title: item.type.title,
                      subtitle: item.type.subtitle,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
