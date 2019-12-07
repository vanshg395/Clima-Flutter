import 'package:flutter/material.dart';

import '../services/weather.dart';
import '../services/location.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var myLocation = Location();
  Map<String, dynamic> weatherData;
  bool _isLoading = true;

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  void getLocationData() async {
    await myLocation.getCurrentLocation();

    weatherData = await WeatherModel().getLocationWeather(myLocation);
    _isLoading = false;
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LocationScreen(weatherData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(child: CircularProgressIndicator()) : null,
    );
  }
}
