import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final Function(String)? onChanged; // Callback for text change

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isPassword = false, // By default, it won't obscure text
    this.onChanged, // Optional onChanged callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      onChanged: onChanged, // Trigger the callback when the text changes
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 16.sp), // Responsive font size
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r), // Responsive border radius
          borderSide: BorderSide(width: 1.w), // Responsive border width
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 14.h, // Responsive vertical padding
          horizontal: 16.w, // Responsive horizontal padding
        ),
      ),
    );
  }
}
