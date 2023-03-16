import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/src/pages/splash/view/splash_view.dart';

import '../pages/home/view/home_page.dart';

class CustomNavigation {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '': (context) => const SplashPage(),
  };

  static navigateHome(BuildContext context, Position position) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(position: position),
      ),
    );
  }
}
