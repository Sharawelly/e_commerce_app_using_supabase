import 'package:flutter/material.dart';
import 'package:e_commerce_app_using_supabase/core/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.suffIcon,
    this.isSecured = false,
    this.keyboardType,
    this.controller,
  });
  final String labelText;
  final Widget? suffIcon;
  final bool isSecured;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSecured,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This Field is Required";
        }
        return null;
      },
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: suffIcon,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.kBordersideColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.kBordersideColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.kBordersideColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
