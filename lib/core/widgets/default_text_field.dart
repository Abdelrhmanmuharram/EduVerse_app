import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;

  const DefaultTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
  });

  @override
  State<DefaultTextField> createState() => _UmsTextFieldState();
}

class _UmsTextFieldState extends State<DefaultTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: AppTheme.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: AppTheme.hintText,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(widget.prefixIcon, color: AppTheme.hintText),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppTheme.hintText,
                  size: 20,
                ),
                onPressed: () {
                  _obscureText = !_obscureText;
                  setState(() {});
                },
              )
            : null,
        filled: true,
        fillColor: AppTheme.white,
      ),
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      autovalidateMode: .onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      minLines: widget.maxLines,
    );
  }
}
