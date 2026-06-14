import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/model/user_model.dart';
import '../view/instructor_details.dart';
import '../viewmodel/instructor_viewmodel.dart';

class InstructorCard extends StatefulWidget {
  final List<UserModel> instructors;
  const InstructorCard({super.key, required this.instructors});

  @override
  State<InstructorCard> createState() => _InstructorCardState();
}

class _InstructorCardState extends State<InstructorCard> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final vm = context.read<InstructorViewModel>();
    return Expanded(
      child: widget.instructors.isEmpty
          ? Center(
              child: Text(
                'No instructors found',
                style: textTheme.headlineSmall,
              ),
            )
          : RefreshIndicator(
            onRefresh: () async {
              await vm.loadInstructors();
            },
            color: AppTheme.primaryLight,
            backgroundColor: AppTheme.white,
            child: ListView.builder(
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
                              Text(
                                instructor.email,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider.value(
                                          value: context.read<InstructorViewModel>(),
                                        ),
                                      ],
                                      child: const InstructorDetails(),
                                    ),
                                    settings: RouteSettings(
                                      arguments: widget.instructors[index],
                                    ),
                                  ),
                                );
                              },
                              child: Icon(Icons.edit, color: AppTheme.primaryLight),
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  widget.instructors.removeAt(index);
                                });
                              },
                                child: Icon(Icons.delete, color: AppTheme.red),),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      instructor.isActive
                                          ? 'Instructor account unlocked'
                                          : 'Instructor account locked',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Icon(
                                instructor.isActive
                                    ? Icons.lock
                                    : Icons.lock_open,
                                color: instructor.isActive
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
          ),
    );
  }
}
