import 'package:edusync_app/core/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/widgets/default_field_lable.dart';
import '../../../../core/widgets/default_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../auth/login/viewmodel/login_view_model.dart';
import '../../student/widgets/student_avatar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  UserModel? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    user = await LocalStorageService.getUser();
    fullNameController.text = user?.fullName ?? '';
    roleController.text = user?.roles.isNotEmpty == true
        ? user!.roles.first
        : '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text('Profile', style: textTheme.headlineSmall),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: 14),
            Center(child: StudentAvatar()),
            SizedBox(height: 24),
            FieldLabel(label: 'Full Name'),
            SizedBox(height: 6),
            DefaultTextField(
              readOnly: true,
              hint: 'Full Name',
              prefixIcon: SvgPicture.asset(
                'assets/icons/name.svg',
                width: 24,
                height: 24,
                fit: .scaleDown,
              ),
              controller: fullNameController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 6),
            FieldLabel(label: 'Role'),
            SizedBox(height: 6),
            DefaultTextField(
              readOnly: true,
              hint: 'Role',
              prefixIcon: SvgPicture.asset(
                'assets/icons/user_role.svg',
                height: 24,
                width: 24,
                fit: .scaleDown,
              ),
              controller: roleController,
              keyboardType: TextInputType.text,
            ),
            Spacer(),
            PrimaryButton(
              color: Colors.red,
              label: 'LogOut',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel', style: textTheme.titleSmall),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            await context.read<LoginViewModel>().logout();
                          },
                          child: Text(
                            'Logout',
                            style: textTheme.titleSmall!.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
