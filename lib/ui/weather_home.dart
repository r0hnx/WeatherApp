import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/ui/city_selection.dart';
import 'package:weather_app/ui/weather_forecast.dart';
import 'location.dart';

class WeatherHome extends StatefulWidget {
  @override
  State < WeatherHome > createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State < WeatherHome > {
  Completer < void > _refreshCompleter;

  @override
  void initState() {
    _refreshCompleter = Completer < void > ();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('weather.io', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 28), ),
        actions: < Widget > [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black87, ),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                BlocProvider.of < WeatherBloc > (context)
                  .add(FetchWeather(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer < WeatherBloc, WeatherState > (
          listener: (context, state) {
            if (state is WeatherLoaded) {
              _refreshCompleter ?.complete();
              _refreshCompleter = Completer();
            }
          },
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoaded) {
              final weather = state.weather;

              return Container(
                color: Colors.transparent,
                child: RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of < WeatherBloc > (context).add(
                      RefreshWeather(city: weather.location),
                    );
                    return _refreshCompleter.future;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        children: < Widget > [
                          SizedBox(height: 10, ),
                          Location(location: weather.location),
                          SizedBox(height: 20, ),
                          Forecast(forecast: weather.forecast,),
                          SizedBox(height: 50, ),
                          Center(child: SizedBox(
                            width: 0.4 * MediaQuery.of(context).size.width,
                            child: Image.network(weather.img)
                          )),
                          SizedBox(height: 50, ),
                          Center(child: Column(
                            children: < Widget > [
                              Text(' ${weather.temp.toStringAsFixed(0)}°', style: TextStyle(fontSize: 58, fontWeight: FontWeight.w600), ),
                              Text('${weather.formattedCondition}', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500), )
                            ],
                          ), ),
                          SizedBox(height: 50, ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: < Widget > [
                                Column(
                                  children: < Widget > [
                                    Text('${(weather.windSpeed * 1.609).toStringAsFixed(0)}km/h', style: TextStyle(fontSize: 22, letterSpacing: -1, color: Colors.black87, fontWeight: FontWeight.bold), ),
                                    SizedBox(height: 10, ),
                                    Text('Wind', style: TextStyle(fontSize: 18, color: Colors.black26, fontWeight: FontWeight.bold), )
                                  ],
                                ),
                                Column(
                                  children: < Widget > [
                                    Text('${weather.humidity}%', style: TextStyle(fontSize: 22, letterSpacing: -1, color: Colors.black87, fontWeight: FontWeight.bold), ),
                                    SizedBox(height: 10, ),
                                    Text('Humidity', style: TextStyle(fontSize: 18, color: Colors.black26, fontWeight: FontWeight.bold), )
                                  ],
                                ),
                                Column(
                                  children: < Widget > [
                                    Text('${weather.maxTemp.toStringAsFixed(0)}°', style: TextStyle(fontSize: 22, letterSpacing: -1, color: Colors.black87, fontWeight: FontWeight.bold), ),
                                    SizedBox(height: 10, ),
                                    Text('Maximum', style: TextStyle(fontSize: 18, color: Colors.black26, fontWeight: FontWeight.bold), )
                                  ],
                                ),
                              ], ),
                          )
                        ],
                      ),
                  ),
                ),
              );
            }
            if (state is WeatherError) {
              return SizedBox(
                  width: 0.65 * MediaQuery.of(context).size.width,
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/img/location.jpg'),
                    Text(
                      'Something went wrong!',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              );
            }
            return Center(child: InkWell(
              onTap: () async {
                  final city = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CitySelection(),
                  ),
                );
                if (city != null) {
                  BlocProvider.of < WeatherBloc > (context)
                    .add(FetchWeather(city: city));
                }
              },
              child: SizedBox(
                width: 0.65 * MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset('assets/img/astro.png'),
                    SizedBox(height: 20,),
                    Text('Please select a city to continue.')
                  ],
                ))
              ));
          },
        ),
      ),
    );
  }
}