part of 'current_weather_position_cubit.dart';

enum CurrentWeatherPositionStatus { loading, success, error }

class CurrentWeatherPositionState {
  CurrentWeatherPositionState({
    this.status = CurrentWeatherPositionStatus.loading,
    this.weather,
  });

  final CurrentWeatherPositionStatus status;
  final WeatherModel? weather;

  CurrentWeatherPositionState copyWith({
    CurrentWeatherPositionStatus? status,
    WeatherModel? weather,
  }) {
    return CurrentWeatherPositionState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }
}
