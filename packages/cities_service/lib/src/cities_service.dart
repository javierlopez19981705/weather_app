import 'package:shared_preferences/shared_preferences.dart';

/// {@template cities_service}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class CitiesService {
  /// {@macro cities_service}
  CitiesService({required this.prefs});

  ///
  Future<SharedPreferences> prefs;

  ///
  Future<List<String>> addCity({required String city}) async {
    final sp = await prefs;
    final cities = await getCities();
    cities.add(city);
    await sp.setStringList('cities', cities);
    return getCities();
  }

  ///
  Future<List<String>> getCities() async {
    final sp = await prefs;

    return sp.getStringList('cities') ?? [];
  }
}
