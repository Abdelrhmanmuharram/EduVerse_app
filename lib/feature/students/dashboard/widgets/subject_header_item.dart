import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../materials/model/student_subject_model.dart';
import '../view_model/student_subject_details_view_model.dart';

class SubjectHeaderItem extends StatelessWidget {
  const SubjectHeaderItem({super.key});

  @override
  Widget build(BuildContext context) {
    final subject =
        ModalRoute.of(context)!.settings.arguments as StudentSubjectModel;
    TextTheme textTheme = Theme.of(context).textTheme;
    final vm = context.watch<StudentSubjectDetailsViewModel>();
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 36),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            color: AppTheme.primaryLight,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/over.svg',
                        width: 24,
                        height: 24,
                        fit: BoxFit.scaleDown,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        subject.department.englishName,
                        style: textTheme.titleSmall!.copyWith(
                          color: AppTheme.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subject.subjectName,
                  style: textTheme.headlineMedium!.copyWith(
                    color: AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.person_outlined,
                      color: AppTheme.white.withOpacity(.7),
                      size: 24,
                    ),
                    SizedBox(width: 4),
                    Text(
                      vm.instructors.isNotEmpty
                          ? vm.instructors
                                .map((e) => 'Dr. ${e.fullName}')
                                .join(', ')
                          : 'Instructor Not Assigned',
                      style: textTheme.titleLarge!.copyWith(
                        color: AppTheme.white.withOpacity(.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: AppTheme.white.withOpacity(.7),
                      size: 24,
                    ),
                    SizedBox(width: 4),
                    Text(
                      vm.systemSetting?.currentSemester.englishName ?? '',
                      style: textTheme.titleLarge!.copyWith(
                        color: AppTheme.white.withOpacity(.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.20,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppTheme.hintText, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.black.withOpacity(.1),
                      offset: Offset(0, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 24,
                            color: AppTheme.primaryLight,
                          ),
                          Spacer(),
                          Text(
                            vm.attendedSessions.toString(),
                            style: textTheme.headlineLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Attendance',
                        style: textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.black,
                        ),
                      ),
                      Text(
                        '${vm.attendedSessions} days attendance',
                        style: textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppTheme.secondText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppTheme.hintText, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.black.withOpacity(.1),
                      offset: Offset(0, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.book_outlined,
                            size: 24,
                            color: AppTheme.blueGray,
                          ),
                          Spacer(),
                          Text(
                            vm.materials.length.toString(),
                            style: textTheme.headlineLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.blueGray,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Materials',
                        style: textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.black,
                        ),
                      ),
                      Text(
                        'New added today',
                        style: textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppTheme.secondText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppTheme.hintText, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.black.withOpacity(.1),
                      offset: Offset(0, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.perm_contact_calendar_outlined,
                            size: 24,
                            color: AppTheme.primaryLight,
                          ),
                          Spacer(),
                          Text(
                            vm.totalSessions.toString(),
                            style: textTheme.headlineLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total Sessions',
                        style: textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
