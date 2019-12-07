import 'package:flutter/material.dart';

import '../screens/city_screen.dart';
import '../utilities/constants.dart';
import '../services/weather.dart';
import '../services/location.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();

  LocationScreen(this.weatherData);

  final Map<String, dynamic> weatherData;
}

class _LocationScreenState extends State<LocationScreen> {
  Map<String, dynamic> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = widget.weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.orange,
              Colors.green,
            ],
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var myLocation = Location();
                        await myLocation.getCurrentLocation();
                        weatherData =
                            await WeatherModel().getLocationWeather(myLocation);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ),
                        ).then(
                          (cityName) async {
                            if (cityName != null) {
                              weatherData =
                                  await WeatherModel().getCityWeather(cityName);
                              setState(() {});
                            }
                          },
                        );
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              weatherData['cod'] == 200
                  ? Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            (weatherData['main']['temp']).toInt().toString() +
                                '\u00b0C',
                            style: kTempTextStyle,
                          ),
                          Text(
                            '${WeatherModel().getWeatherIcon(weatherData['weather'][0]['id'])}',
                            style: kConditionTextStyle,
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                      'City Not Found',
                      textAlign: TextAlign.center,
                      style: kTempTextStyle,
                    )),
              weatherData['cod'] == 200
                  ? Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        "${WeatherModel().getMessage((weatherData['main']['temp']).toInt())} in ${weatherData['name']}",
                        textAlign: TextAlign.right,
                        style: kMessageTextStyle,
                      ),
                    )
                  : Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
