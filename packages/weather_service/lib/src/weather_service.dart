import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_repository/weather_repository.dart';

///
class WeatherService {
  /// {@macro weather_service}
  WeatherService({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// {@macro reservamos_service}
  // ReservamosService();

  final http.Client _httpClient;
  final String _baseUrl = 'api.openweathermap.org';
  final _apiKey = '537a023fdeee7cc0432adf47a8c158c6';

  ///
  Future<Map<String, dynamic>> fetchWeather({
    required String lat,
    required String lon,
    required List<ExcludeOptions> excludeOptions,
    required UnitsWeather units,
  }) async {
    /// lat={lat}&lon={lon}&exclude={part}&appid={API key}
    const endPoint = 'data/3.0/onecall';

    var exclude = '';

    for (var i = 0; i < excludeOptions.length; i++) {
      if (i == excludeOptions.length - 1) {
        exclude += excludeOptions[i].name;
      } else {
        exclude += '${excludeOptions[i].name},';
      }
    }

    final parameters = {
      'lat': lat,
      'lon': lon,
      'exclude': exclude,
      'units': units.name,
      'appid': _apiKey,
    };

    http.Response response;
    dynamic body;

    final uri = Uri.https(_baseUrl, endPoint, parameters);
    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw HttpRequestException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestException();
    }

    try {
      body = jsonDecode(response.body);
    } on Exception {
      throw JsonDecodeException();
    }

    try {
      return body as Map<String, dynamic>;
    } on Exception {
      throw JsonDecodeException();
    }
  }
}

///
class HttpRequestException implements Exception {}

///
class JsonDecodeException implements Exception {}
