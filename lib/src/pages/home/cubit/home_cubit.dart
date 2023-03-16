import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:weather_repository/weather_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  StreamController<UnitsWeather> streamController =
      StreamController.broadcast();

  changeUnit({required UnitsWeather unit}) {
    streamController.add(unit);
    emit(HomeState(
      units: unit,
    ));
  }
}
