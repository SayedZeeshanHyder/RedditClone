import 'package:flutter/material.dart';

import 'colors.dart';

final lightTheme = ThemeData(

  useMaterial3: true,

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: appColor,
    ),

  ),

  appBarTheme: AppBarTheme(
    backgroundColor: appColor,
    centerTitle: true
  )

);