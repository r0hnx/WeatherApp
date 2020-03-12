import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/bloc_delegate.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/repository/repository.dart';
import 'package:weather_app/repository/weather_repo.dart';
import 'package:weather_app/ui/weather_home.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;
  App({
      Key key,
      @required this.weatherRepository
    }): assert(weatherRepository != null),
    super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Weather',
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: WeatherHome(),
      ),
    );
  }
}