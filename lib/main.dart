import 'package:flutter/material.dart';
import 'package:weather_app/src/pages/splash/view/splash_view.dart';

import 'src/utils/custom_navigation.dart';
import 'src/utils/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: customTheme(),
      home: const SplashPage(),
      routes: CustomNavigation.routes,
    );
  }
}
