import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool _isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          _isDarkTheme ? const Color(0xFF00001a) : const Color(0xFFFFFFFF),
      primaryColor: Colors.blue,
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary: _isDarkTheme
                ? const Color(0xFF1a1f3c)
                : const Color(0xFFE8FDFD),
            brightness: _isDarkTheme ? Brightness.dark : Brightness.light,
          ),
      cardColor:
          _isDarkTheme ? const Color(0xFF0a0d26) : const Color(0xFFE8FDFD),
      canvasColor: _isDarkTheme ? Colors.black : Colors.grey[50],
    );
  }
}
