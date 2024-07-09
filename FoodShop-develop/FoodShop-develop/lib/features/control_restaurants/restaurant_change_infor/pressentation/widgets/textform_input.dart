import 'package:find_food/core/configs/app_colors.dart';
import 'package:flutter/material.dart';

class textFormInput extends StatelessWidget {
  final String label;
  const textFormInput({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 0),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your ${label}';
        }
        // if (!controller.validateEmail()) {
        //   return "Email invalid";
        // }
        return null;
      },
    );
  }
}
