import 'package:weather_repository/src/models/weather_model.dart';
import 'package:weather_service/weather_service.dart';

/// {@template weather_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WeatherRepository {
  /// {@macro weather_repository}
  WeatherRepository({WeatherService? weatherService})
      : _weatherService = weatherService ?? WeatherService();

  final WeatherService _weatherService;

  ///
  Future<WeatherModel> getWeather({
    required String lat,
    required String lon,
  }) async {
    final data = await _weatherService.fetchWeather(lat: lat, lon: lon);

    // try {
    return WeatherModel.fromJson(data);
    // } catch (e) {
    //   throw Exception();
    // }
  }
}
