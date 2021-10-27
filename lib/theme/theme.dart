import 'package:flutter/material.dart';
import 'package:depth_spectrum/theme/colors.dart';

ThemeData dsTheme() {
  TextTheme _textTheme(TextTheme base) {
    return base.copyWith(
      bodyText1: base.bodyText1!.copyWith(
        color: DSColors.white
      ),
      bodyText2: base.bodyText2!.copyWith(
        color: DSColors.black
      ),
    );
  }
  AppBarTheme _appbarTheme(AppBarTheme base) {
    return base.copyWith(
      centerTitle: true,
      color: DSColors.darkred,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: DSColors.white
      ),
    );
  }
  FloatingActionButtonThemeData _floatingActionButtonTheme(
      FloatingActionButtonThemeData base) {
    return base.copyWith(
      backgroundColor: DSColors.darkred,
      foregroundColor: DSColors.white,
      shape: const CircleBorder()
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _textTheme(base.textTheme),
    appBarTheme: _appbarTheme(base.appBarTheme),
    floatingActionButtonTheme:
        _floatingActionButtonTheme(base.floatingActionButtonTheme),
  );
}