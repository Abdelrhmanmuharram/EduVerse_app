import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/default_text_field.dart';

class InstructorProfile extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController fullNameController;
  final Function(String?) onRoleChanged;
  final bool showPassword;

  const InstructorProfile({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.fullNameController,
    required this.onRoleChanged,
    this.showPassword = true,
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
            const SizedBox(height: 16),
            DefaultTextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              hint: 'Full Name',
              controller: fullNameController,
              validator: (value) => AppValidators.requiredField(value, 'Full Name'),
              prefixIcon: SvgPicture.asset(
                'assets/icons/@.svg',
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(height: 24),
            DefaultTextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              hint: 'Instructor Email',
              prefixIcon: null,
              controller: emailController,
              validator: AppValidators.emailValidator,
            ),
            const SizedBox(height: 16),
            if (showPassword)
              DefaultTextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                hint: 'Password',
                prefixIcon: null,
                controller: passwordController,
                validator: AppValidators.passwordValidator,
                isPassword: true,
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
