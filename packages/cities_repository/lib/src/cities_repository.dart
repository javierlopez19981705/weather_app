import 'package:cities_repository/src/models/city_model.dart';
import 'package:cities_service/cities_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template cities_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class CitiesRepository {
  /// {@macro cities_repository}
  CitiesRepository({required Future<SharedPreferences> prefs}) {
    citiesService = CitiesService(prefs: prefs);
  }

  ///
  late CitiesService citiesService;

  ///
  Future<List<CityModel>> saveCity({required CityModel city}) async {
    final citiesData = await citiesService.addCity(city: cityModelToJson(city));
    return citiesData.map(cityModelFromJson).toList();
  }

  ///
  Future<List<CityModel>> getCities() async {
    final citiesData = await citiesService.getCities();
    return citiesData.map(cityModelFromJson).toList();
  }
}
