part of 'weather_cities_cubit.dart';

enum WeatherCitiesStatus { loading, success, error }

class WeatherCitiesState {
  WeatherCitiesState({
    this.cities = const [],
    this.status = WeatherCitiesStatus.loading,
  });

  final List<CityModel> cities;
  final WeatherCitiesStatus status;

  WeatherCitiesState copyWith({
    List<CityModel>? cities,
    WeatherCitiesStatus? status,
  }) {
    return WeatherCitiesState(
      cities: cities ?? this.cities,
      status: status ?? this.status,
    );
  }
}
