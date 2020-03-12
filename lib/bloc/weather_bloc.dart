import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/repository/weather_repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc < WeatherEvent, WeatherState > {

  final WeatherRepository weatherRepository;

  WeatherBloc({
    @required this.weatherRepository
  }): assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream < WeatherState > mapEventToState(WeatherEvent event) async *{
    if (event is FetchWeather) {
      yield* _mapFetchWeatherToState(event);
    } else if (event is RefreshWeather) {
      yield* _mapRefreshWeatherToState(event);
    }
  }

  Stream < WeatherState > _mapFetchWeatherToState(FetchWeather event) async *{
    yield WeatherLoading();
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoaded(weather: weather);
    } catch (_) {
      yield WeatherError();
    }
  }

  Stream < WeatherState > _mapRefreshWeatherToState(RefreshWeather event) async *{
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoaded(weather: weather);
    } catch (_) {
      yield state;
    }
  }

}