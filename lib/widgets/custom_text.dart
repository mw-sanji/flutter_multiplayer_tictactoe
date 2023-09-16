import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final List<Shadow> shadows;
  final String text;
  final double fontSize;
  const CustomText({super.key, required this.shadows, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: fontSize,
      shadows: shadows
    )
    ));
  }
}