import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/src/utils/spaces.dart';
import 'package:weather_app/src/widgets/progress_bar_widget.dart';
import 'package:weather_repository/weather_repository.dart';

import '../../../utils/custom_text_style.dart';
import '../cubit/current_weather_position_cubit.dart';
import '../../../widgets/card_information.dart';

class CurrentWeatherPosition extends StatelessWidget {
  const CurrentWeatherPosition({
    super.key,
    required this.position,
  });

  final Position position;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentWeatherPositionCubit,
        CurrentWeatherPositionState>(
      builder: (context, state) => _body(
        context: context,
        state: state,
      ),
    );
  }

  Widget _body({
    required BuildContext context,
    required CurrentWeatherPositionState state,
  }) {
    switch (state.status) {
      case CurrentWeatherPositionStatus.loading:
        return const Center(
          child: ProgressBarWidget(),
        );

      case CurrentWeatherPositionStatus.success:
        return _BodySuccess(
          weather: state.weather!,
        );

      case CurrentWeatherPositionStatus.error:
        return const Center(
          child: Text('Ha ocurrido un error'),
        );
    }
  }
}

class _BodySuccess extends StatelessWidget {
  const _BodySuccess({required this.weather});

  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            spaceHeight(),
            _image(
              context: context,
              weather: weather.daily[0].weather[0].main.toLowerCase(),
            ),
            spaceHeight(),
            _temp(temp: weather.daily[0].temp.day.toString()),
            spaceHeight(),
            spaceHeight(),
            _tempMinMax(
              min: weather.daily[0].temp.min.toString(),
              max: weather.daily[0].temp.max.toString(),
            ),
            spaceHeight(),
            spaceHeight(),
            _values(weather: weather, context: context),
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
      width: size.width * .55,
      height: size.width * .55,
    );
  }

  Widget _temp({required String temp}) {
    return Text(
      '$temp º',
      style: const TextStyle(
        fontSize: 45,
      ),
    );
  }

  Widget _values({
    required WeatherModel weather,
    required BuildContext context,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          spaceWidth(),
          CardInformation(
            icon: Icons.thermostat,
            label: 'Sensacion termcica',
            information: '${weather.daily[0].feelsLike.day}º',
          ),
          spaceWidth(),
          CardInformation(
            icon: Icons.air,
            label: 'Velocidad viento',
            information: '${weather.daily[0].windSpeed} m/s',
          ),
          spaceWidth(),
          CardInformation(
            icon: Icons.umbrella,
            label: 'Precipitacion',
            information: '${weather.daily[0].pop * 100} %',
          ),
          spaceWidth(),
        ],
      ),
    );
  }

  Widget _tempMinMax({required String min, required String max}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Text('Min', style: styleBody),
            spaceHeight(),
            Text('$min º', style: styleHeadingBold),
          ],
        ),
        Column(
          children: [
            const Text('Max', style: styleBody),
            spaceHeight(),
            Text('$max º', style: styleHeadingBold),
          ],
        ),
      ],
    );
  }
}
