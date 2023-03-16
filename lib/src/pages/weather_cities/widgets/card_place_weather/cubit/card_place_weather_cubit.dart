import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cities_repository/cities_repository.dart';
import 'package:weather_repository/weather_repository.dart';

part 'card_place_weather_state.dart';

class CardPlaceWeatherCubit extends Cubit<CardPlaceWeatherState> {
  CardPlaceWeatherCubit({
    required this.weatherRepository,
    required this.city,
    required this.unit,
    required this.unitStream,
  }) : super(CardPlaceWeatherState()) {
    if (city.weather == null || city.unit != unit) {
      city.unit = unit;
      getWeather();
    } else {
      emit(state.copyWith(
        status: CardPlaceWeatherStatus.success,
        weather: city.weather,
      ));
    }

    streamOpen = unitStream.listen((event) {
      unit = event;
      getWeather();
    });
  }

  final WeatherRepository weatherRepository;
  final CityModel city;
  UnitsWeather unit;
  Stream<UnitsWeather> unitStream;
  late StreamSubscription streamOpen;

  getWeather() async {
    final weather = await weatherRepository.getWeather(
      lat: city.latitude.toString(),
      lon: city.longitude.toString(),
      units: unit,
    );

    city.weather = weather;

    emit(state.copyWith(
      status: CardPlaceWeatherStatus.success,
      weather: city.weather,
    ));
  }

  @override
  Future<void> close() async {
    streamOpen.cancel();
    return super.close();
  }
}
