import 'package:flutter/material.dart';

class AppThemes {
  static final light = ThemeData(
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.green;
          }
          return Colors.grey;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        trackColor: WidgetStateProperty.all(Colors.transparent),
      ),
      primaryColor: const Color(0xFFff5722),
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        labelStyle: const TextStyle(color: Color(0xff7B80F1)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: const BorderSide(
            color: Color(0xff4C52CB), // or any color you want
            width: 4,
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20, left: 40),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: const BorderSide(
            color: Colors.red, // or any color you want
            width: 4,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: const BorderSide(
            color: Colors.red, // or any color you want
            width: 4,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: const BorderSide(
            color: Color(0xff4C52CB), // or any color you want
            width: 4,
          ),
        ),
      ),
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black)),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFff5722),
          primary: const Color(0xFFff5722),
          brightness: Brightness.light,
          surface: Colors.white),
      cardColor: Colors.white);
}
