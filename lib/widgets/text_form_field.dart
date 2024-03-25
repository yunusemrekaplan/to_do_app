import 'package:flutter/material.dart';

import '../utils/constants/padding.dart';
import '../utils/constants/text_style.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isObscureText = false,
    this.toggleVisibility,
    this.isVisible = false,
    this.confirmPasswordController,
  });

  TextEditingController controller;

  String hintText;
  Function validator;
  bool isObscureText;

  void Function()? toggleVisibility;
  bool isVisible;

  TextEditingController? confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingConstants.bottom16,
      child: TextFormField(
        controller: controller,
        style: TextStyleConstants.textField,
        validator: (value) {
          if (confirmPasswordController != null) {
            return validator(value, confirmPasswordController!.text);
          } else {
            return validator(value);
          }
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyleConstants.textFieldHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: assignSuffixIconBasedOnHintText(),
        ),
        obscureText: isVisible,
      ),
    );
  }

  IconButton? assignSuffixIconBasedOnHintText() {
    IconButton? suffixIcon;

    if (isObscureText) {
      suffixIcon = _buildIconButton();
    }
    return suffixIcon;
  }

  IconButton _buildIconButton() {
    return IconButton(
      onPressed: toggleVisibility,
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
      ),
    );
  }
}
