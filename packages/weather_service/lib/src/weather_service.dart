import 'dart:convert';

import 'package:http/http.dart' as http;

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
  }) async {
    /// lat={lat}&lon={lon}&exclude={part}&appid={API key}
    const endPoint = 'data/3.0/onecall';
    final parameters = {
      'lat': lat,
      'lon': lon,
      'exclude': 'current,minutely,hourly',
      'units': 'metric',
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
