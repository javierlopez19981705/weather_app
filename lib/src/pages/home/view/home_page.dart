import 'package:card_swiper/card_swiper.dart';
import 'package:cities_repository/cities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/src/pages/weather_cities/cubit/weather_cities_cubit.dart';
import 'package:weather_repository/weather_repository.dart';

import '../../current_weather_position/cubit/current_weather_position_cubit.dart';
import '../../current_weather_position/view/current_weather_position.dart';
import '../../weather_cities/view/weather_cities_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.position,
    super.key,
  });

  final Position position;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => CitiesRepository(
                  prefs: SharedPreferences.getInstance(),
                ),
              ),
              RepositoryProvider<WeatherRepository>(
                create: (context) => WeatherRepository(),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<WeatherCitiesCubit>(
                  create: (context) => WeatherCitiesCubit(
                    citiesRepository: context.read<CitiesRepository>(),
                  )..getCities(),
                ),
                BlocProvider<CurrentWeatherPositionCubit>(
                  create: (context) => CurrentWeatherPositionCubit(
                    weatherRepository: context.read<WeatherRepository>(),
                    position: position,
                    unit: state.units,
                    unitStream:
                        context.read<HomeCubit>().streamController.stream,
                  )..getWeather(),
                ),
              ],
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).primaryColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: _HomeView(position: position),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({required this.position});

  final Position position;

  @override
  Widget build(BuildContext context) {
    return Swiper.children(
      viewportFraction: 0.8,
      scale: 0.97,
      loop: false,
      physics: const BouncingScrollPhysics(),
      children: [
        CurrentWeatherPosition(position: position),
        const WeatherCitiesView(),
      ],
    );
  }
}
