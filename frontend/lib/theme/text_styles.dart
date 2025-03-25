import 'package:flutter/material.dart';
import 'color_schemes.dart';

extension CustomTextStyles on ThemeData {
  TextStyle get cvName => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: colorScheme.cvAccent,
    letterSpacing: 1.2,
    height: 1.2,
    fontFamily: 'Roboto',
  );

  TextStyle get cvJobTitle =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  TextStyle get cvSectionHeader =>
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black);

  TextStyle get cvEntryTitle => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: colorScheme.cvAccent,
  );
}
