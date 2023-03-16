import 'package:weather_repository/weather_repository.dart';

void main() async {
  final service = WeatherRepository();
  final data = await service.getWeather(
    lat: '25.6866142',
    lon: '-100.3161126',
  );

  print(data);
}
