import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
    ),
    useMaterial3: false,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      centerTitle: false,
    ));
