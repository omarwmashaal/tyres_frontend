import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainText extends StatelessWidget {
  final String text;

  const MainText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp, // Responsive font size
        color: Colors.black87,
      ),
    );
  }
}
