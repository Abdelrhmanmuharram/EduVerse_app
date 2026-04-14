import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/widgets/default_field_lable.dart';
import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/core/widgets/language_selector.dart';
import 'package:edusync_app/core/widgets/default_logo.dart';
import 'package:edusync_app/core/widgets/default_button.dart';
import 'package:edusync_app/feature/admin/view/screens/panel_view.dart';
import 'package:edusync_app/feature/admin/view/screens/admin_home_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 2));

    setState(() => _isLoading = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful!'),
          backgroundColor: AppTheme.green,
        ),
      );
      await Future.delayed(Duration(seconds: 2));
      Navigator.of(context).pushNamed(AdminHomeView.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: LanguageSelector(),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Center(
                    child: Column(
                      children: [
                        DefaultLogo(size: 80),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Edu",
                                style: TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "Sync",
                                style: TextStyle(
                                  color: AppTheme.primaryLight,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'University Management System',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Sign in to continue',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.hintText,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  FieldLabel(label: 'Username'),
                  const SizedBox(height: 8),
                  DefaultTextField(
                    hint: 'Enter your username',
                    prefixIcon: Icon(Icons.person_outline),
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  FieldLabel(label: 'Password'),
                  const SizedBox(height: 8),
                  DefaultTextField(
                    hint: '••••••••',
                    prefixIcon: Icon(Icons.lock_outline),
                    isPassword: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    label: 'Login',
                    onPressed: _handleLogin,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 48),
                  Center(
                    child: Text(
                      'POWERED BY GLOBAL UNIVERSITY NETWORK',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.hintText,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
