import 'package:card_swiper/card_swiper.dart';
import 'package:cities_repository/cities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/pages/home/cubit/home_cubit.dart';
import 'package:weather_app/src/pages/weather_cities/cubit/weather_cities_cubit.dart';
import 'package:weather_app/src/utils/colors.dart';
import 'package:weather_app/src/utils/spaces.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

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
                  lazy: false,
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
                  body: Stack(
                    children: [
                      Positioned.fill(
                        child: _HomeView(position: position),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: SafeArea(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<HomeCubit>()
                                      .changeUnit(unit: UnitsWeather.imperial);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      state.units == UnitsWeather.imperial
                                          ? accentColorLight
                                          : const Color.fromARGB(
                                              255, 181, 181, 181),
                                ),
                                child: const Text('ºF'),
                              ),
                              spaceWidth(),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<HomeCubit>()
                                      .changeUnit(unit: UnitsWeather.metric);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      state.units == UnitsWeather.metric
                                          ? accentColorLight
                                          : const Color.fromARGB(
                                              255, 181, 181, 181),
                                ),
                                child: const Text('ºC'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child:
                            BlocBuilder<WeatherCitiesCubit, WeatherCitiesState>(
                          builder: (context, state) => FloatingActionButton(
                            onPressed: () {
                              context
                                  .read<WeatherCitiesCubit>()
                                  .displayPrediction(context);
                            },
                            mini: true,
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ),
                    ],
                  ),
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
