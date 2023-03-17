import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:weather_app/src/pages/weather_cities/cubit/weather_cities_cubit.dart';
import 'package:weather_app/src/pages/weather_cities/widgets/card_place_weather/view/card_place_weather_view.dart';
import 'package:weather_app/src/utils/spaces.dart';
import 'package:weather_app/src/widgets/progress_bar_widget.dart';

class WeatherCitiesView extends StatelessWidget {
  const WeatherCitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCitiesCubit, WeatherCitiesState>(
      builder: (context, state) {
        switch (state.status) {
          case WeatherCitiesStatus.loading:
            return const Center(
              child: ProgressBarWidget(),
            );

          case WeatherCitiesStatus.success:
            return SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: state.cities.isEmpty
                        ? const Center(
                            child: Text(
                              'Aun no has agregado ciudades',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 60,
                            ),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => CardPlaceWeather(
                              city: state.cities[index],
                            ),
                            separatorBuilder: (context, index) => spaceHeight(),
                            itemCount: state.cities.length,
                          ),
                  ),
                  // Positioned(
                  //   bottom: 10,
                  //   right: 10,
                  //   child: FloatingActionButton(
                  //     onPressed: () {
                  //       displayPrediction(context);
                  //     },
                  //     mini: true,
                  //     child: const Icon(Icons.add),
                  //   ),
                  // ),
                ],
              ),
            );

          case WeatherCitiesStatus.error:
            return const Center(
              child: ProgressBarWidget(),
            );
        }
      },
    );
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
      context.read<WeatherCitiesCubit>().addCity(
            id: detail.result.placeId,
            name: detail.result.formattedAddress ?? '',
            latitude: detail.result.geometry!.location.lat,
            longitude: detail.result.geometry!.location.lat,
          );
    }
  }
}
