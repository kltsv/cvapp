import 'package:flutter/material.dart';

class AppTheme {
  static const _defaultFontFamily = 'Roboto';

  static ThemeData theme(bool isDark) {
    final brightness = isDark ? Brightness.dark : Brightness.light;
    final theme = ThemeData(
      brightness: brightness,
      fontFamily: _defaultFontFamily,
    );
    return theme.copyWith(
      iconTheme: theme.iconTheme.copyWith(size: 32),
    );
  }
}
