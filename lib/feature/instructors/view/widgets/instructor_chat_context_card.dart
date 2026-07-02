import 'package:edusync_app/core/widgets/default_drop_down_field.dart';
import 'package:edusync_app/feature/instructors/viewmodel/attendance_session_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_theme.dart';
import '../../../students/chat_bot/view_model/student_chat_bot_view_model.dart';
import '../../../students/chat_bot/widgets/material_drop_item.dart';
import '../../viewmodel/materials_viewmodel.dart';

class AIContextCard extends StatefulWidget {
  const AIContextCard({super.key});

  @override
  State<AIContextCard> createState() => AIContextCardState();
}

class AIContextCardState extends State<AIContextCard>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  void collapse() {
    if (_isExpanded) {
      setState(() {
        _isExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<AttendanceSessionViewModel>();
    return TapRegion(
      onTapOutside: (_) {
        if (_isExpanded) {
          setState(() {
            _isExpanded = false;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.hintText.withOpacity(.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: AppTheme.primaryLight,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Context",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: _isExpanded ? 0 : 0.5,
                    duration: const Duration(milliseconds: 250),
                    child: const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: AppTheme.primaryLight,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: _isExpanded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 22),
                        Text(
                          "SELECT SUBJECT",
                          style: textTheme.labelSmall?.copyWith(
                            color: AppTheme.secondText,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DefaultDropDownField(
                          selectedItem: viewModel.selectedSubject?.subject.name,
                          onChanged: (value) async {
                            final subject = viewModel.subjects.firstWhere(
                              (e) => e.subject.name == value,
                            );

                            await viewModel.selectSubject(subject);
                          },
                          items: viewModel.subjects
                              .map((e) => e.subject.name)
                              .toList(),
                          hint: 'Select Subject',
                          icon: 'subject',
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "MATERIALS",
                          style: textTheme.labelSmall?.copyWith(
                            color: AppTheme.secondText,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (viewModel.selectedSubject == null)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "Please select a subject first",
                              style: TextStyle(color: AppTheme.hintText),
                            ),
                          )
                        else if (viewModel.materials.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "No materials found",
                              style: TextStyle(color: AppTheme.hintText),
                            ),
                          )
                        else
                          SizedBox(
                            height: viewModel.materials.length <= 2
                                ? viewModel.materials.length * 72.0
                                : 144,
                            child: ListView.separated(
                              physics: viewModel.materials.length <= 2
                                  ? const NeverScrollableScrollPhysics()
                                  : const AlwaysScrollableScrollPhysics(),
                              itemCount: viewModel.materials.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (_, index) {
                                final material = viewModel.materials[index];
                                return MaterialDropItem(
                                  onTap: () {
                                    viewModel.toggleMaterial(material);
                                  },
                                  selected: viewModel.isMaterialSelected(material),
                                  title: material.title,
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: 8),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
