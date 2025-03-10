import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

class AppTheme {
  static ThemeData defaultTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: accentColor,
      tertiary: ratingColor,
      surface: backgroundColor,
      onPrimary: textColor,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.bebasNeue(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: textColor,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: accentColor,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      titleTextStyle: GoogleFonts.orbitron(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    ),
  );
}
