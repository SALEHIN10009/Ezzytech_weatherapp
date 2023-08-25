import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  CustomText({
    required this.txt,
    required this.textColor,
    required this.fs,
    required this.fw,
    required this.lspace,
  });

  String txt;
  Color textColor;
  double fs;
  FontWeight fw;
  double lspace;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: GoogleFonts.dmSans(
        color: textColor,
        fontSize: fs,
        fontWeight: fw,
        letterSpacing: lspace,
      ),
    );
  }
}
