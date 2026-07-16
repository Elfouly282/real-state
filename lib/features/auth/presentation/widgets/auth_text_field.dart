import 'package:flutter/material.dart';
import '../../../../core/constant/custom_textformfield.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextformfeild(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      formFieldKey: null,
      labelText: label,
      hintText: hint,
      isPassword: isPassword,
    );
  }
}
