import 'package:bloc/bloc.dart';
import 'package:cities_repository/cities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

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

  deleteCity({required CityModel city}) async {
    await citiesRepository.deleteCity(city: city);
    state.cities.remove(city);
    emit(state.copyWith(
      cities: state.cities,
    ));
  }

  Future<void> displayPrediction(BuildContext context) async {
    const apiKeyMaps2 = 'AIzaSyB4d1TiE3N2vdxefCZ9vr9MIYrh4FM1Uok';
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: apiKeyMaps2,
      radius: 100000000000,
      types: ['(regions)'],
      strictbounds: false,
      mode: Mode.fullscreen,
      language: "es",
      components: [
        // Component(Component.country, 'mx'),
      ],
    );

    if (p != null) {
      const apiKeyMaps2 = 'AIzaSyB4d1TiE3N2vdxefCZ9vr9MIYrh4FM1Uok';
      GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: apiKeyMaps2,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail = await places.getDetailsByPlaceId(
        p.placeId!,
      );

      // ignore: use_build_context_synchronously
      addCity(
        id: detail.result.placeId,
        name: detail.result.formattedAddress ?? '',
        latitude: detail.result.geometry!.location.lat,
        longitude: detail.result.geometry!.location.lat,
      );
    }
  }
}
