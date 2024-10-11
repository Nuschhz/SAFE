import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'Poppins',
  dividerTheme: const DividerThemeData(color: Colors.transparent),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF171717)),
    bodyMedium: TextStyle(color: Color(0xFF171717)),
    bodySmall: TextStyle(color: Color(0xFF171717)),
  ).apply(
    bodyColor: const Color(0xFF171717),
    displayColor: const Color(0xFFFAFAFA),
  ),
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    primary: Color(0xFF4ADE80),
    onPrimary: Color(0xFFFAFAFA),
    secondary: Color(0xFFF5F5F5),
    onSecondary: Color(0xFF737373),
    onSecondaryFixed: Color(0xFFE5E5E5),
    tertiary: Color(0xFFF59E0B),
    surface: Color(0xFFFAFAFA),
    onSurface: Color(0xFF171717),
    error: Color(0xFFEF4444),
  ),
  useMaterial3: true,
);

ThemeData darkMode = ThemeData(
  fontFamily: 'Poppins',
  dividerTheme: const DividerThemeData(color: Colors.transparent),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFFAFAFA)),
    bodyMedium: TextStyle(color: Color(0xFFFAFAFA)),
    bodySmall: TextStyle(color: Color(0xFFFAFAFA)),
  ).apply(
    bodyColor: const Color(0xFFFAFAFA),
    displayColor: const Color(0xFF171717),
  ),
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    primary: Color(0xFF4ADE80),
    onPrimary: Color(0xFFFAFAFA),
    secondary: Color(0xFF262626),
    onSecondary: Color(0xFFFAFAFA),
    onSecondaryFixed: Color(0xFF404040),
    onSecondaryContainer: Color(0xFF737373),
    tertiary: Color(0xFFB45309),
    surface: Color(0xFF171717),
    onSurface: Color(0xFFFAFAFA),
    error: Color(0xFFB91C1C),
  ),
  useMaterial3: true,
);
