import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final TextAlign? textAlign;
  final bool? softWrap ;

  const CustomText({super.key,
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.textColor, this.textAlign, this.softWrap});

  @override
  Widget build(BuildContext context) {
    return Text(text ,
      textAlign: textAlign,
      softWrap: softWrap,
      style: GoogleFonts.roboto(
        color:textColor,
        fontSize:fontSize,
        fontWeight:fontWeight,)
      ,);
  }
}
