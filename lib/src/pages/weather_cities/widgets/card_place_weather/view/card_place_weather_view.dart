import 'package:cities_repository/cities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/pages/weather_cities/cubit/weather_cities_cubit.dart';
import 'package:weather_app/src/utils/spaces.dart';
import 'package:weather_app/src/widgets/progress_bar_widget.dart';
import 'package:weather_repository/weather_repository.dart';

import '../../../../../utils/custom_text_style.dart';
import '../../../../../widgets/card_information.dart';
import '../../../../home/cubit/home_cubit.dart';
import '../cubit/card_place_weather_cubit.dart';

class CardPlaceWeather extends StatelessWidget {
  const CardPlaceWeather({super.key, required this.city});

  final CityModel city;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => CardPlaceWeatherCubit(
            weatherRepository: context.read<WeatherRepository>(),
            city: city,
            unit: state.units,
            unitStream: context.read<HomeCubit>().streamController.stream,
          ),
          child: _CardPlaceWeather(
            city: city,
          ),
        );
      },
    );
  }
}

class _CardPlaceWeather extends StatelessWidget {
  const _CardPlaceWeather({required this.city});

  final CityModel city;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    city.name,
                    style: styleSubtitleBold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<WeatherCitiesCubit>().deleteCity(city: city);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            BlocBuilder<CardPlaceWeatherCubit, CardPlaceWeatherState>(
              builder: (context, state) {
                switch (state.status) {
                  case CardPlaceWeatherStatus.loading:
                    return const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: ProgressBarWidget(),
                      ),
                    );

                  case CardPlaceWeatherStatus.success:
                    return Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _image(
                                  context: context,
                                  weather: state
                                      .weather!.daily[0].weather[0].main
                                      .toLowerCase(),
                                ),
                                spaceWidth(),
                                Text(
                                    '${state.weather?.daily[0].temp.day.toString()}'),
                              ],
                            ),
                            spaceHeight(),
                            Row(
                              children: [
                                CardInformation(
                                  icon: Icons.thermostat,
                                  label: 'Sensacion termcica',
                                  information:
                                      '${state.weather!.daily[0].feelsLike.day}',
                                ),
                                spaceWidth(),
                                BlocBuilder<HomeCubit, HomeState>(
                                  builder: (context, stateHome) {
                                    return CardInformation(
                                      icon: Icons.air,
                                      label: 'Velocidad viento',
                                      information:
                                          '${state.weather?.daily[0].windSpeed}  ${stateHome.units == UnitsWeather.metric ? 'm/s' : 'mil/h'} ',
                                    );
                                  },
                                ),
                                spaceWidth(),
                                CardInformation(
                                  icon: Icons.umbrella,
                                  label: 'Precipitacion',
                                  information:
                                      '${state.weather!.daily[0].pop * 100} %',
                                ),
                              ],
                            ),
                            spaceHeight(),
                            Row(
                              children: [
                                CardInformation(
                                  icon: Icons.water_drop_outlined,
                                  label: 'Humedad',
                                  information:
                                      '${state.weather?.daily[0].humidity}',
                                ),
                                spaceWidth(),
                                CardInformation(
                                  icon: Icons.cloud_outlined,
                                  label: 'Nubes',
                                  information:
                                      '${state.weather!.daily[0].clouds}',
                                ),
                                spaceWidth(),
                                CardInformation(
                                  icon: Icons.wb_sunny_outlined,
                                  label: 'UV Index',
                                  information: '${state.weather?.daily[0].uvi}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );

                  case CardPlaceWeatherStatus.error:
                    return const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text('Ha ocurrido un error'),
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _image({required BuildContext context, required String weather}) {
    final size = MediaQuery.of(context).size;
    String url;

    switch (weather) {
      case 'clouds':
        url = 'assets/images/cloudy-day.png';
        break;

      case 'drizzle':
        url = 'assets/images/dropplets.png';
        break;

      case 'rain':
        url = 'assets/images/raining.png';
        break;

      case 'snow':
        url = 'assets/images/snow.png';
        break;

      case 'clear':
        url = 'assets/images/sunny.png';
        break;

      case 'thunderstorm':
        url = 'assets/images/thunder.png';
        break;

      default:
        url = 'assets/images/wind.png';
        break;
    }

    return Image.asset(
      url,
      width: size.width * .06,
      height: size.width * .06,
    );
  }
}
