import 'package:flutter/material.dart';

import 'colors.dart';

customTheme() => ThemeData(
      brightness: Brightness.light,
      primarySwatch: primaryColorLightMaterial,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColorLightMaterial,
        secondary: accentColorLight,
      ),
      iconTheme: const IconThemeData(color: Color.fromRGBO(0, 35, 74, 1)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(0, 35, 74, 1)),
        toolbarTextStyle: TextStyle(color: Color.fromRGBO(0, 35, 74, 1)),
        titleTextStyle: TextStyle(color: Color.fromRGBO(0, 35, 74, 1)),
        foregroundColor: Color.fromRGBO(0, 35, 74, 1),
      ),
    );
