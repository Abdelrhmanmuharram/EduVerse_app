import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../model/instructor_model.dart';
import '../view/instructor_details.dart';

class InstructorCard extends StatefulWidget {
  final List<InstructorsModel> instructors;
  const InstructorCard({super.key, required this.instructors});

  @override
  State<InstructorCard> createState() => _InstructorCardState();
}

class _InstructorCardState extends State<InstructorCard> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: widget.instructors.isEmpty
          ? Center(
              child: Text(
                'No instructors found',
                style: textTheme.headlineSmall,
              ),
            )
          : ListView.builder(
              itemCount: widget.instructors.length,
              itemBuilder: (context, index) {
                final instructor = widget.instructors[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppTheme.white,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: AppTheme.primaryLight.withOpacity(0.2),
                        child: Icon(Icons.person, color: AppTheme.primaryLight),
                      ),
                      title: Text(
                        instructor.fullName,
                        style: textTheme.titleMedium,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (instructor.subjects.isNotEmpty)
                            Text(
                              instructor.email,
                              style: textTheme.titleSmall!.copyWith(
                                color: AppTheme.secondText,
                              ),
                            ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final updatedInstructor = await Navigator.pushNamed(
                                context,
                                InstructorDetails.routeName,
                                arguments: widget.instructors[index],
                              );
                              if (updatedInstructor != null &&
                                  updatedInstructor is InstructorsModel) {
                                setState(() {
                                  widget.instructors[index] = updatedInstructor;
                                });
                              }
                            },
                            child: Icon(Icons.edit),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                widget.instructors.removeAt(index);
                              });
                            },
                              child: Icon(Icons.delete)),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                instructor.isLocked = !instructor.isLocked;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    instructor.isLocked
                                        ? 'Instructor account unlocked'
                                        : 'Instructor account locked',
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Icon(
                              instructor.isLocked
                                  ? Icons.lock
                                  : Icons.lock_open,
                              color: instructor.isLocked
                                  ? AppTheme.red
                                  : Colors.green,
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
