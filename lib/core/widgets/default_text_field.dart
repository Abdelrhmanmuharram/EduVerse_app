import 'package:edusync_app/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultTextField extends StatefulWidget {
  final String hint;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final String? prefixSvg;
  final Function(String)? onChanged;
  final TextInputAction? textInputAction;


  const DefaultTextField({
    super.key,
    this.readOnly = false,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
    this.prefixSvg,
    this.onChanged,
    this.textInputAction,
  });

  @override
  State<DefaultTextField> createState() => _UmsTextFieldState();
}

class _UmsTextFieldState extends State<DefaultTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      onChanged: (value) {

        widget.onChanged?.call(value);
      },
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
        prefixIcon: widget.prefixSvg != null
            ? SvgPicture.asset(widget.prefixSvg!)
            : widget.prefixIcon,
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
        fillColor: widget.readOnly
            ? AppTheme.black.withValues(alpha: 0.08)
            : AppTheme.white,
      ),
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      autovalidateMode: .onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      maxLines: widget.maxLines,
      enabled: widget.readOnly ? false : true,
    );
  }
}
