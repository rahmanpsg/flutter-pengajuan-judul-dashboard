import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/themes/app_colors.dart';

class CustomTextFieldOutline extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function()? onTap;
  final bool readOnly;
  final bool obscureText;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color color;
  final Color outlineColor;
  final Function(String)? onChanged;
  final Function()? onSuffixIconTap;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const CustomTextFieldOutline({
    Key? key,
    this.controller,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.color = backgroundColor,
    this.outlineColor = mainGreyColor,
    this.onChanged,
    this.onSuffixIconTap,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: outlineColor,
      ),
      borderRadius: BorderRadius.circular(6),
    );

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onTap: onTap,
      readOnly: readOnly,
      obscureText: obscureText,
      obscuringCharacter: '*',
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: color,
        filled: true,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder.copyWith(
          borderSide: const BorderSide(
            color: mainColor,
            width: 1.5,
          ),
        ),
        errorBorder: outlineInputBorder.copyWith(
          borderSide: const BorderSide(
            color: dangerColor,
          ),
        ),
        focusedErrorBorder: outlineInputBorder.copyWith(
          borderSide: const BorderSide(
            color: dangerColor,
            width: 1.5,
          ),
        ),
        hintText: hintText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon == null
            ? null
            : SizedBox(
                height: 50,
                width: 50,
                child: GestureDetector(
                  onTap: onSuffixIconTap,
                  child: suffixIcon,
                ),
              ),
        errorMaxLines: 2,
      ),
    );
  }
}
