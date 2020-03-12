import 'package:flutter/material.dart';

class Forecast extends StatefulWidget {
  final List forecast;
  Forecast({@required this.forecast});

  static String _mapToWeekDay(String input) {
    String state;
    switch (input) {
      case '1':
        state = 'Monday';
        break;
      case '2':
        state = 'Tuesday';
        break;
      case '3':
        state = 'Wednesday';
        break;
      case '4':
        state = 'Thursday';
        break;
      case '5':
        state = 'Friday';
        break;
      case '6':
        state = 'Saturday';
        break;
      case '7':
        state = 'Sunday';
        break;
      default:
        state = 'Unknown';
    }
    return state;
  }

  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  @override
  Widget build(BuildContext context) {
    if(widget.forecast.length > 4) {
      widget.forecast.removeAt(0);
      widget.forecast.removeAt(4);
    } 
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.forecast.map((f) => Column(
          children: <Widget>[
            Text('${Forecast._mapToWeekDay(DateTime.parse(f['applicable_date']).weekday.toString())}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black87),),
            SizedBox(height: 10,),
            SizedBox(
              width: 35,
              child: Image.network('https://www.metaweather.com/static/img/weather/png/64/${f['weather_state_abbr']}.png')),
            SizedBox(height: 10,),
            Text(' ${f['the_temp'].toStringAsFixed(0)}°', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87),)
          ],
        )).toList(),
      ),
    );
  }
}