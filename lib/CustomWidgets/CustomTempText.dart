import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFontText extends StatelessWidget {
  final double fontSize;
  final String text;

  const CustomFontText({
    Key? key,
    required this.fontSize, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
       text,
      style: GoogleFonts.handlee(
        fontSize: fontSize,
        color: Colors.white, // You can customize the color here if needed
      ),
    );
  }
}
