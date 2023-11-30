import 'package:flutter/material.dart';

ColorScheme lightColorScheme = const ColorScheme.light(
  primary: Color.fromARGB(255, 52, 85, 11),
  primaryContainer: Color.fromARGB(255, 40, 64, 9),
  secondary: Color.fromARGB(255, 0, 128, 255),
  secondaryContainer: Color.fromARGB(255, 0, 102, 204),
  surface: Color.fromARGB(255, 255, 255, 255),
  surfaceVariant: Color.fromARGB(255, 214, 214, 214),
  onSurfaceVariant: Color.fromARGB(255, 165, 165, 165),
  background: Color.fromARGB(255, 243, 246, 189),
  error: Color.fromARGB(255, 255, 0, 0),
  onPrimary: Color.fromARGB(255, 221, 233, 185),
  onSecondary: Color.fromARGB(255, 255, 255, 255),
  onSurface: Color.fromARGB(255, 0, 0, 0),
  onBackground: Color.fromARGB(255, 0, 0, 0),
  onError: Color.fromARGB(255, 255, 255, 255),
);

ThemeData lightThemeData = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
);
