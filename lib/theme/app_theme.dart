import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorList = <Color>[
  Colors.amber,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;
  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false,
  })  : assert(selectedColor >= 0, 'Color index must be greater than 0'),
        assert(selectedColor < colorList.length,
            'Color index must be less than ${colorList.length}');
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorList[5],
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.montserratAlternates().copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      );
  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) =>
      AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
