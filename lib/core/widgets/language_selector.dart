import 'package:edusync_app/core/app_theme.dart';
import 'package:edusync_app/core/model/language_model.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.language, color: AppTheme.secondText),
          SizedBox(width: 6),
          DropdownButton(
            isDense: true,
            itemHeight: 60,
            value: 'en',
            items: LanguageModel.languages
                .map(
                  (language) => DropdownMenuItem(
                    value: language.code,
                    child: Text(language.name),
                  ),
                )
                .toList(),
            onChanged: (value) {},
            dropdownColor: AppTheme.white,
            borderRadius: BorderRadius.circular(16),
            underline: SizedBox(),
          ),
        ],
      ),
    );
  }
}
