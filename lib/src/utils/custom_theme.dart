import 'package:flutter/material.dart';

import 'colors.dart';

customTheme() => ThemeData(
      primarySwatch: primaryColorLightMaterial,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColorLightMaterial,
        secondary: accentColorLight,
      ),
      iconTheme: const IconThemeData(color: Color.fromRGBO(0, 35, 74, 1)),
    );
