import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/src/pages/home/view/widgets/current_weather_position/view/current_weather_position.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.position,
    super.key,
  });

  final Position position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurrentWeatherPosition(position: position),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red.withOpacity(.5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],
      ),
    );
  }
}

// class _HomeView extends StatelessWidget {
//   const _HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
