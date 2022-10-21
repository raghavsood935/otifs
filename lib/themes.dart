import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: GoogleFonts.jost().fontFamily,
      colorScheme: const ColorScheme.light(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xff1C1C1E),
      colorScheme: const ColorScheme.dark(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff1C1C1E),
      ));
}
