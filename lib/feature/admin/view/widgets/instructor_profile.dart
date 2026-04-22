import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/widgets/default_text_field.dart';

class InstructorProfile extends StatelessWidget {
  final TextEditingController codeController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final Function(String?) onRoleChanged;
  final String? selectedRole;

  const InstructorProfile({
    super.key,
    required this.codeController,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.onRoleChanged,
    this.selectedRole,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppTheme.primaryLight.withOpacity(0.1),
                  foregroundColor: AppTheme.primaryLight,
                  child: const Icon(Icons.person_add),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("New Profile", style: textTheme.headlineSmall),
                    Text(
                      "Fill in the primary details",
                      style: textTheme.titleMedium!.copyWith(
                        color: AppTheme.hintText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            DefaultTextField(
              hint: 'Instructor Code',
              prefixIcon: null,
              controller: codeController,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DefaultTextField(
                    hint: 'First Name',
                    prefixIcon: null,
                    controller: firstNameController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DefaultTextField(
                    hint: 'Last Name',
                    prefixIcon: null,
                    controller: lastNameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DefaultTextField(
              hint: 'Username',
              controller: usernameController,
              prefixIcon: SvgPicture.asset(
                'assets/icons/@.svg',
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(height: 16),
            DefaultDropDownField(
              items: [
                "Professor",
                "Assistant Professor",
                "Associate Professor",
                "Teaching Assistant",
                "Lecturer",
              ],
              hint: selectedRole ?? 'Academic Role',
              icon: 'name',
              onChanged: onRoleChanged,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}