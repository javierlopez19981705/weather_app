part of 'card_place_weather_cubit.dart';

enum CardPlaceWeatherStatus { loading, success, error }

class CardPlaceWeatherState {
  CardPlaceWeatherState({
    this.status = CardPlaceWeatherStatus.loading,
    this.weather,
  });
  final CardPlaceWeatherStatus status;
  final WeatherModel? weather;

  CardPlaceWeatherState copyWith({
    CardPlaceWeatherStatus? status,
    WeatherModel? weather,
  }) {
    return CardPlaceWeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }
}
