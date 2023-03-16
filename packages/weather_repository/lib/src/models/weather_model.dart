// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';

///
WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str) as Map<String, dynamic>);

///
String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

///
class WeatherModel {
  ///
  WeatherModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.daily,
    required this.alerts,
  });

  ///
  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        lat: json['lat'] as double,
        lon: json['lon'] as double,
        timezone: json['timezone'] as String,
        timezoneOffset: json['timezone_offset'] as int,
        daily: List<Daily>.from(
          (json['daily'] as List<dynamic>).map(
            (element) => Daily.fromJson(element as Map<String, dynamic>),
          ),
        ),
        alerts: List<Alert>.from(
          ((json['alerts'] ?? <dynamic>[]) as List<dynamic>).map(
            (element) => Alert.fromJson(element as Map<String, dynamic>),
          ),
        ),
      );

  ///
  double lat;

  ///
  double lon;

  ///
  String timezone;

  ///
  int timezoneOffset;

  ///
  List<Daily> daily;

  ///
  List<Alert>? alerts;

  ///
  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
        'timezone': timezone,
        'timezone_offset': timezoneOffset,
        'daily': List<dynamic>.from(daily.map((x) => x.toJson())),
        'alerts':
            List<dynamic>.from(alerts ?? <Alert>[].map((x) => x.toJson())),
      };
}

///
class Alert {
  ///
  Alert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  ///
  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        senderName: json['sender_name'] as String,
        event: json['event'] as String,
        start: json['start'] as int,
        end: json['end'] as int,
        description: json['description'] as String,
        tags: List<String>.from(
          (json['tags'] as List<Map<String, dynamic>>).map((x) => x),
        ),
      );

  ///
  String senderName;

  ///
  String event;

  ///
  int start;

  ///
  int end;

  ///
  String description;

  ///
  List<String> tags;

  ///
  Map<String, dynamic> toJson() => {
        'sender_name': senderName,
        'event': event,
        'start': start,
        'end': end,
        'description': description,
        'tags': List<dynamic>.from(tags.map((x) => x)),
      };
}

///
class Daily {
  ///
  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.uvi,
    this.rain,
  });

  ///
  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: (json['dt'] as int) * 1000,
        sunrise: json['sunrise'] as int,
        sunset: json['sunset'] as int,
        moonrise: json['moonrise'] as int,
        moonset: json['moonset'] as int,
        moonPhase: double.parse('${json['moon_phase']}'),
        temp: Temp.fromJson(json['temp'] as Map<String, dynamic>),
        feelsLike:
            FeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>),
        pressure: json['pressure'] as int,
        humidity: json['humidity'] as int,
        dewPoint: double.parse('${json['dew_point']}'),
        windSpeed: double.parse('${json['wind_speed']}'),
        windDeg: json['wind_deg'] as int,
        windGust: double.parse('${json['wind_gust']}'),
        weather: List<Weather>.from(
          (json['weather'] as List<dynamic>).map(
            (element) => Weather.fromJson(element as Map<String, dynamic>),
          ),
        ),
        clouds: json['clouds'] as int,
        pop: double.parse('${json['pop']}'),
        uvi: double.parse('${json['uvi']}'),
        rain: double.tryParse('${json['rain']}'),
      );

  ///
  int dt;

  ///
  int sunrise;

  ///
  int sunset;

  ///
  int moonrise;

  ///
  int moonset;

  ///
  double moonPhase;

  ///
  Temp temp;

  ///
  FeelsLike feelsLike;

  ///
  int pressure;

  ///
  int humidity;

  ///
  double dewPoint;

  ///
  double windSpeed;

  ///
  int windDeg;

  ///
  double windGust;

  ///
  List<Weather> weather;

  ///
  int clouds;

  ///
  double pop;

  ///
  double? rain;

  ///
  double uvi;

  ///

  ///
  Map<String, dynamic> toJson() => {
        'dt': dt,
        'sunrise': sunrise,
        'sunset': sunset,
        'moonrise': moonrise,
        'moonset': moonset,
        'moon_phase': moonPhase,
        'temp': temp.toJson(),
        'feels_like': feelsLike.toJson(),
        'pressure': pressure,
        'humidity': humidity,
        'dew_point': dewPoint,
        'wind_speed': windSpeed,
        'wind_deg': windDeg,
        'wind_gust': windGust,
        'weather': List<dynamic>.from(weather.map((x) => x.toJson())),
        'clouds': clouds,
        'pop': pop,
        'rain': rain,
        'uvi': uvi,
      };
}

///
class FeelsLike {
  ///
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  ///
  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: double.parse('${json["day"]}'),
        night: double.parse('${json["night"]}'),
        eve: double.parse('${json["eve"]}'),
        morn: double.parse('${json["morn"]}'),
      );

  ///
  double day;

  ///
  double night;

  ///
  double eve;

  ///
  double morn;

  ///
  Map<String, dynamic> toJson() => {
        'day': day,
        'night': night,
        'eve': eve,
        'morn': morn,
      };
}

///
class Temp {
  ///
  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  ///
  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: double.parse('${json['day']}'),
        min: double.parse('${json['min']}'),
        max: double.parse('${json['max']}'),
        night: double.parse('${json['night']}'),
        eve: double.parse('${json['eve']}'),
        morn: double.parse('${json['morn']}'),
      );

  ///
  double day;

  ///
  double min;

  ///
  double max;

  ///
  double night;

  ///
  double eve;

  ///
  double morn;

  ///
  Map<String, dynamic> toJson() => {
        'day': day,
        'min': min,
        'max': max,
        'night': night,
        'eve': eve,
        'morn': morn,
      };
}

///
class Weather {
  ///
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  ///
  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'] as int,
        main: json['main'] as String,
        description: json['description'] as String,
        icon: json['icon'] as String,
      );

  ///
  int id;

  ///
  String main;

  ///
  String description;

  ///
  String icon;

  ///
  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}
