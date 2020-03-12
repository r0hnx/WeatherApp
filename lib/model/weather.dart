import 'package:equatable/equatable.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition condition;
  final String applicableDate;
  final String formattedCondition;
  final double minTemp;
  final int humidity;
  final double temp;
  final double maxTemp;
  final double windSpeed;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;
  final String img;
  final List forecast;

  const Weather({
    this.condition,
    this.applicableDate,
    this.formattedCondition,
    this.minTemp,
    this.humidity,
    this.temp,
    this.maxTemp,
    this.windSpeed,
    this.locationId,
    this.created,
    this.lastUpdated,
    this.location,
    this.img,
    this.forecast
  });

  @override
  List<Object> get props => [
        condition,
        applicableDate,
        formattedCondition,
        minTemp,
        temp,
        maxTemp,
        locationId,
        created,
        lastUpdated,
        location,
        img,
        forecast
      ];

  static Weather fromJson(dynamic json) {
    final consolidatedWeather = json['consolidated_weather'][0];
    return Weather(
      condition: _mapStringToWeatherCondition(consolidatedWeather['weather_state_abbr']),
      applicableDate: consolidatedWeather['applicable_date'],
      formattedCondition: consolidatedWeather['weather_state_name'],
      minTemp: consolidatedWeather['min_temp'] as double,
      humidity: consolidatedWeather['humidity'],
      temp: consolidatedWeather['the_temp'] as double,
      maxTemp: consolidatedWeather['max_temp'] as double,
      windSpeed: consolidatedWeather['wind_speed'] as double,
      locationId: json['woeid'] as int,
      created: consolidatedWeather['created'],
      lastUpdated: DateTime.now(),
      location: json['title'],
      img: "https://www.metaweather.com/static/img/weather/png/${consolidatedWeather['weather_state_abbr']}.png",
      forecast: json['consolidated_weather']
    );
  }

  static WeatherCondition _mapStringToWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'sn':
        state = WeatherCondition.snow;
        break;
      case 'sl':
        state = WeatherCondition.sleet;
        break;
      case 'h':
        state = WeatherCondition.hail;
        break;
      case 't':
        state = WeatherCondition.thunderstorm;
        break;
      case 'hr':
        state = WeatherCondition.heavyRain;
        break;
      case 'lr':
        state = WeatherCondition.lightRain;
        break;
      case 's':
        state = WeatherCondition.showers;
        break;
      case 'hc':
        state = WeatherCondition.heavyCloud;
        break;
      case 'lc':
        state = WeatherCondition.lightCloud;
        break;
      case 'c':
        state = WeatherCondition.clear;
        break;
      default:
        state = WeatherCondition.unknown;
    }
    return state;
  }
}
