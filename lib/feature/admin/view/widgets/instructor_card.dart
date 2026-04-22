import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../model/instructor_model.dart';

class InstructorCard extends StatelessWidget {
  final List<InstructorsModel> instructors;
  const InstructorCard({super.key, required this.instructors});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: instructors.isEmpty
          ? Center(
        child: Text(
          'No instructors found',
          style: textTheme.headlineSmall,
        ),
      )
          : ListView.builder(
        itemCount: instructors.length,
        itemBuilder: (context, index) {
          final instructor = instructors[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.white,
              ),
              child: ListTile(
                onTap: (){
                  Navigator.pushNamed(context, '/instructor-details', arguments: instructor);
                },
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.primaryLight
                      .withOpacity(0.2),
                  child: Icon(
                    Icons.person,
                    color: AppTheme.primaryLight,
                  ),
                ),
                title: Text(
                  "${instructor.firstName} ${instructor.lastName}",
                  style: textTheme.titleMedium!.copyWith(
                    color: AppTheme.black,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      instructor.username.toUpperCase(),
                      style: textTheme.titleSmall!.copyWith(
                        color: AppTheme.hintText,
                      ),
                    ),
                    Text(instructor.academicRole,
                        style: textTheme.titleSmall!.copyWith(
                          color: AppTheme.hintText,
                        )),
                    if (instructor.subjects.isNotEmpty)
                      Text(
                        instructor.subjects
                            .map((e) => e.code)
                            .join(', '),
                        style: textTheme.titleSmall!.copyWith(
                          color: AppTheme.secondText,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
