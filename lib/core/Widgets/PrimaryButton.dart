import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.h), // Responsive vertical padding
        minimumSize: Size(double.infinity, 48.h), // Full width button, responsive height
        textStyle: TextStyle(fontSize: 16.sp), // Responsive text size
      ),
      child: Text(text),
    );
  }
}
