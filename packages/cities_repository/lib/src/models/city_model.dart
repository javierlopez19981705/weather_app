import 'dart:convert';

import 'package:weather_repository/weather_repository.dart';

///
CityModel cityModelFromJson(String str) =>
    CityModel.fromJson(json.decode(str) as Map<String, dynamic>);

///
String cityModelToJson(CityModel data) => json.encode(data.toJson());

///
class CityModel {
  ///
  CityModel({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.id,
    this.weather,
    this.unit,
  });

  ///
  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        // ignore: avoid_dynamic_calls
        latitude: json['latitude']?.toDouble() as double,
        // ignore: avoid_dynamic_calls
        longitude: json['longitude']?.toDouble() as double,
        name: json['name'] as String,
        id: json['id'] as String,
      );

  ///
  double latitude;

  ///
  double longitude;

  ///
  String name;

  ///
  String id;

  ///
  WeatherModel? weather;

  ///
  UnitsWeather? unit;

  ///
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'name': name,
        'id': id,
      };
}
