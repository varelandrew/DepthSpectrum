import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:depth_spectrum/theme/colors.dart';

DSTheme currentTheme = DSTheme();

class DSTheme with ChangeNotifier {
  static bool _isDark = false;
  ThemeMode get currentTheme => _isDark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: DSColors.darkred,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: DSColors.white),
      backgroundColor: DSColors.white,
      scaffoldBackgroundColor: DSColors.white,
      textTheme: const TextTheme(
        headline1: TextStyle(color: DSColors.black),
        headline2: TextStyle(color: DSColors.black),
        bodyText1: TextStyle(color: DSColors.black),
        bodyText2: TextStyle(color: DSColors.black),
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: DSColors.darkred,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: DSColors.white),
      backgroundColor: DSColors.black,
      scaffoldBackgroundColor: DSColors.black,
      textTheme: const TextTheme(
        headline1: TextStyle(color: DSColors.white),
        headline2: TextStyle(color: DSColors.white),
        bodyText1: TextStyle(color: DSColors.white),
        bodyText2: TextStyle(color: DSColors.white),
      ),
    );
  }
}

// ThemeData dsTheme() {
//   TextTheme _textTheme(TextTheme base) {
//     return base.copyWith(
//       bodyText1: base.bodyText1!.copyWith(color: DSColors.white),
//       bodyText2: base.bodyText2!.copyWith(color: DSColors.black),
//     );
//   }
//   AppBarTheme _appbarTheme(AppBarTheme base) {
//     return base.copyWith(
//       centerTitle: true,
//       color: DSColors.darkred,
//       elevation: 0,
//       iconTheme: const IconThemeData(color: DSColors.white),
//     );
//   }
//   FloatingActionButtonThemeData _floatingActionButtonTheme(
//       FloatingActionButtonThemeData base) {
//     return base.copyWith(
//       backgroundColor: DSColors.darkred,
//       foregroundColor: DSColors.white,
//     );
//   }
//
//   final ThemeData base = ThemeData.light();
//   return base.copyWith(
//     textTheme: _textTheme(base.textTheme),
//     appBarTheme: _appbarTheme(base.appBarTheme),
//     floatingActionButtonTheme:
//         _floatingActionButtonTheme(base.floatingActionButtonTheme),
//   );
// }