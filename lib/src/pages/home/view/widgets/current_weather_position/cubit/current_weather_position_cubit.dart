import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_repository/weather_repository.dart';

part 'current_weather_position_state.dart';

class CurrentWeatherPositionCubit extends Cubit<CurrentWeatherPositionState> {
  CurrentWeatherPositionCubit(
    this.weatherRepository,
    this.position,
  ) : super(CurrentWeatherPositionState());

  WeatherRepository weatherRepository;
  Position position;

  getWeather() async {
    final resp = await weatherRepository.getWeather(
      lat: position.latitude.toString(),
      lon: position.longitude.toString(),
    );

    emit(state.copyWith(
      status: CurrentWeatherPositionStatus.success,
      weather: resp,
    ));
  }
}
