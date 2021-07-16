import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: const Color(0xFF0097A7),
  primaryColorLight: const Color(0xFFB2EBF2),
  primaryColor: const Color(0xFF00BCD4),
  accentColor: const Color(0xFF009688),
  scaffoldBackgroundColor: const Color(0xFFE0F2F1),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

final darkTheme = theme.copyWith(
  textTheme: GoogleFonts.openSansTextTheme()
      .apply(bodyColor: Colors.white, displayColor: Colors.white),
  primaryColorDark: const Color(0xFF0097A7),
  primaryColorLight: const Color(0xFF1a1d30),
  primaryColor: const Color(0xFF272940),
  accentColor: const Color(0xFF009688),
  scaffoldBackgroundColor: const Color(0xFF1a1d30),
  backgroundColor: const Color(0xFF1a1d30),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),

  // backgroundColor: const Color(0xFF1a1d30),
  // text
);
