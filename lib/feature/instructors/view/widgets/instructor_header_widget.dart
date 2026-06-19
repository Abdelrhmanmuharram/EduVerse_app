import 'package:flutter/material.dart';
import 'package:edusync_app/core/app_theme.dart';

import '../../../../core/services/local_storage_service.dart';

class InstructorHeaderWidget extends StatelessWidget {
  const InstructorHeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/images/admin-profile.png"),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WELCOME BACK",
                    style: textTheme.titleSmall!
                        .copyWith(color: AppTheme.secondText),
                  ),
                  FutureBuilder(
                    future: LocalStorageService.getUser(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      }
                      final user = snapshot.data!;
                      return Text(
                        user.fullName,
                        style: textTheme.headlineSmall,
                      );
                    },
                  ),
                ],
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_none),
          )
        ],
      ),
    );
  }
}