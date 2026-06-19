import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_theme.dart';

class DefaultDropDownField extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final String? hint;
  final String? icon;
  final String? errorText;

  final void Function(String?)? onChanged;

  const DefaultDropDownField({
    super.key,
    required this.items,
    required this.hint,
    this.selectedItem,
    this.onChanged,
    this.icon,
    this.errorText,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            if (items.isEmpty) return;
            final RenderBox button = context.findRenderObject() as RenderBox;
            final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;
            final position = RelativeRect.fromRect(
              Rect.fromPoints(
                button.localToGlobal(Offset.zero, ancestor: overlay),
                button.localToGlobal(
                  button.size.bottomRight(Offset.zero),
                  ancestor: overlay,
                ),
              ),
              Offset.zero & overlay.size,
            );
            final selected = await showMenu<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: AppTheme.white,
              elevation: 8,
              context: context,
              position: position,
              items: items.map((item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(Icons.school, color: AppTheme.secondText),
                      SizedBox(width: 8),
                      Text(
                        item,
                        style: selectedItem == item
                            ? Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: AppTheme.black,
                              )
                            : Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: AppTheme.secondText,
                              ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
            if (selected != null) {
              onChanged?.call(selected);
            }
          },
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.border),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/$icon.svg'),
                  SizedBox(width: 6),
                  Text(
                    selectedItem ?? hint!,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppTheme.hintText),
                  ),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down, color: AppTheme.hintText),
                ],
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
