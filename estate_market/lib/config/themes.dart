import 'package:flutter/material.dart';

ColorScheme lightColorScheme = const ColorScheme.light(
  primary: Color.fromARGB(255, 76, 175, 80),
  primaryContainer: Color.fromARGB(255, 129, 199, 132),
  secondary: Color.fromARGB(255, 0, 150, 136),
  surface: Color.fromARGB(255, 255, 255, 255),
  surfaceVariant: Color.fromARGB(255, 237, 237, 237),
  onSurfaceVariant: Color.fromARGB(255, 150, 150, 150),
  background: Color.fromARGB(255, 245, 245, 245),
  error: Color.fromARGB(255, 211, 47, 47),
  onPrimary: Color.fromARGB(255, 255, 255, 255),
  onSurface: Color.fromARGB(255, 0, 0, 0),
  onBackground: Color.fromARGB(255, 0, 0, 0),
  onError: Color.fromARGB(255, 255, 255, 255),
);

ThemeData lightThemeData = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
);

ColorScheme darkColorScheme = const ColorScheme.dark(
  primary: Color.fromARGB(255, 0, 200, 83),
  primaryContainer: Color.fromARGB(255, 0, 150, 13),
  secondary: Color.fromARGB(255, 29, 233, 182),
  surface: Color.fromARGB(255, 18, 18, 18),
  surfaceVariant: Color.fromARGB(255, 55, 55, 55),
  onSurfaceVariant: Color.fromARGB(255, 150, 150, 150),
  background: Color.fromARGB(255, 24, 24, 24),
  error: Color.fromARGB(255, 255, 79, 79),
  onPrimary: Color.fromARGB(255, 0, 0, 0),
  onSurface: Color.fromARGB(255, 255, 255, 255),
  onBackground: Color.fromARGB(255, 255, 255, 255),
  onError: Color.fromARGB(255, 0, 0, 0),
);

ThemeData darkThemeData = ThemeData(
  colorScheme: darkColorScheme,
  useMaterial3: true,
);
