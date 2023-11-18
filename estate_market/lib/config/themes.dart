import 'package:flutter/material.dart';

ColorScheme lightColorScheme = const ColorScheme.light(
  background: Color.fromARGB(255, 243, 246, 189),
  surface: Color.fromARGB(255, 255, 255, 255),
  onSurface: Color.fromARGB(255, 0, 0, 0),
  surfaceVariant: Color.fromARGB(255, 214, 214, 214),
  onSurfaceVariant: Color.fromARGB(255, 165, 165, 165),
  primary: Color.fromARGB(255, 52, 85, 11),
  onPrimary: Color.fromARGB(255, 221, 233, 185),
);

ThemeData lightThemeData = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
);
