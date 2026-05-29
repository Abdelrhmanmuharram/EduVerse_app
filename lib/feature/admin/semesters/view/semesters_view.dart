import 'package:edusync_app/core/widgets/default_text_field.dart';
import 'package:edusync_app/feature/admin/semesters/widgets/add_semester_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_theme.dart';
import '../model/semester_model.dart';
import '../widgets/semesters_list.dart';

class SemestersView extends StatefulWidget {
  static const String routeName = '/semesters';
  const SemestersView({super.key});

  @override
  State<SemestersView> createState() => _SemestersViewState();
}

class _SemestersViewState extends State<SemestersView> {
  List<SemesterModel> allSemesters = [];
  List<SemesterModel> filteredSemesters = [];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Semesters', style: textTheme.headlineMedium),
                  Spacer(),
                  AddSemesters(
                    onTap: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        '/add-semester',
                      );
                      if (!context.mounted) return;
                      if (result != null) {
                        SemesterModel semester = result as SemesterModel;
                        setState(() {
                          allSemesters.add(semester);
                          filteredSemesters = List.from(allSemesters);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppTheme.green,
                            content: Text('Semester added successfully'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              DefaultTextField(
                onChanged: (value) {
                  setState(() {
                    filteredSemesters = allSemesters.where((semester) {
                      return semester.arabicName.toLowerCase().contains(
                            value.toLowerCase(),
                          ) ||
                          semester.englishName.toLowerCase().contains(
                            value.toLowerCase(),
                          );
                    }).toList();
                    if (filteredSemesters.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppTheme.red,
                          content: Text('No semesters found'),
                        ),
                      );
                    }
                  });
                },
                hint: 'Search Semesters',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: filteredSemesters.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.menu_book_outlined, size: 80,color: AppTheme.primaryLight,),
                          SizedBox(height: 16),
                          Text(
                            'No Semesters Yet',
                            style: textTheme.headlineSmall,
                          ),
                          SizedBox(height: 8),
                          Text('Add your first semester'),
                        ],
                      )
                    : SemestersList(
                        semesters: filteredSemesters,
                        onDelete: (semester) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: Text('Delete Semester'),
                                content: Text(
                                  'Are you sure you want to delete this semester?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Cancel',
                                      style: textTheme.titleMedium!.copyWith(
                                        color: AppTheme.primaryLight,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        allSemesters.remove(semester);
                                        filteredSemesters = List.from(
                                          allSemesters,
                                        );
                                      });
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            'Semester deleted successfully',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Delete',
                                      style: textTheme.titleMedium!.copyWith(
                                        color: AppTheme.red,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onEdit: (semester, index) async {
                          final result = await Navigator.pushNamed(
                            context,
                            '/edit-semester',
                            arguments: semester,
                          );
                          if (result != null) {
                            SemesterModel updateSemester =
                                result as SemesterModel;
                            setState(() {
                              allSemesters[index] = updateSemester;
                              filteredSemesters = List.from(allSemesters);
                            });
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
