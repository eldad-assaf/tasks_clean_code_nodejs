import 'package:flutter/material.dart';

TextStyle appStyle(double size, Color color, FontWeight fw) {
  return TextStyle(fontSize: size,color: color,fontWeight: fw);
  
  //**To use google fonts uncomment this: */
  // return GoogleFonts.poppins(fontSize: size, color: color, fontWeight: fw);
}
