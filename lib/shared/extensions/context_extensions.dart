import 'package:flutter/material.dart';

import '../theme/nav_colors.dart';

extension ThemeContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  NavColors get navColors => theme.extension<NavColors>() ?? NavColors.light;
}

extension SnackBarContextX on BuildContext {
  void showSnack(String message, {SnackBarAction? action}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), action: action));
  }
}
