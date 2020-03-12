part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => null;
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  const WeatherLoaded({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {}