import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:flutter/material.dart';

class AdminHeader extends StatefulWidget {
  @override
  State<AdminHeader> createState() => _AdminHeaderState();
}

class _AdminHeaderState extends State<AdminHeader> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Admin Panel',
                    style: textTheme.headlineSmall!.copyWith(fontSize: 24),
                  ),
                  Text(
                    'University Management',
                    style: textTheme.titleSmall!.copyWith(
                      color: AppTheme.secondText,
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/admin-profile.png'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          DefaultTextField(
            hint: 'Search...',
            prefixIcon: Icon(Icons.search),
            controller: _searchController,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
