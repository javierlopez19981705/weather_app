import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_repository/weather_repository.dart';

part 'current_weather_position_state.dart';

class CurrentWeatherPositionCubit extends Cubit<CurrentWeatherPositionState> {
  CurrentWeatherPositionCubit({
    required this.weatherRepository,
    required this.position,
    required this.unitStream,
    required this.unit,
  }) : super(CurrentWeatherPositionState()) {
    streamOpen = unitStream.listen((event) {
      unit = event;
      getWeather();
    });
  }

  WeatherRepository weatherRepository;
  Position position;
  Stream<UnitsWeather> unitStream;
  UnitsWeather unit;
  late StreamSubscription streamOpen;

  getWeather() async {
    try {
      final resp = await weatherRepository.getWeather(
        lat: position.latitude.toString(),
        lon: position.longitude.toString(),
        units: unit,
      );

      emit(state.copyWith(
        status: CurrentWeatherPositionStatus.success,
        weather: resp,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: CurrentWeatherPositionStatus.error,
      ));
    }
  }

  @override
  Future<void> close() async {
    streamOpen.cancel();
    return super.close();
  }
}
