import 'package:bloc/bloc.dart';
import 'package:cities_repository/cities_repository.dart';

part 'weather_cities_state.dart';

class WeatherCitiesCubit extends Cubit<WeatherCitiesState> {
  WeatherCitiesCubit({
    required this.citiesRepository,
  }) : super(WeatherCitiesState());

  final CitiesRepository citiesRepository;

  getCities() async {
    final cities = await citiesRepository.getCities();
    emit(state.copyWith(
      cities: cities,
      status: WeatherCitiesStatus.success,
    ));
  }

  addCity({
    required String id,
    required String name,
    required double latitude,
    required double longitude,
  }) async {
    final cities = await citiesRepository.saveCity(
      city: CityModel(
        latitude: latitude,
        longitude: longitude,
        name: name,
        id: id,
      ),
    );
    emit(state.copyWith(
      cities: cities,
    ));
  }
}
