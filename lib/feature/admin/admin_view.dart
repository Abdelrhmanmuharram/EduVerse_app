import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class AdminView extends StatelessWidget {
  static const String routeName = '/admin';

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
