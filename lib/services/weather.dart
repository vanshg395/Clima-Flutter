import '../services/networking.dart';
import '../services/location.dart';

class WeatherModel {
  NetworkingHelper networkingHelper;
  Map<String, dynamic> weatherData;

  Future<Map<String, dynamic>> getLocationWeather(Location myLocation) async {
    networkingHelper = NetworkingHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${myLocation.latitude}&lon=${myLocation.longitude}&appid=182f64186d901bf6304b0b4bbbe1264d&units=metric');
    weatherData = await networkingHelper.getData();
    return weatherData;
  }

  Future<Map<String, dynamic>> getCityWeather(String cityName) async {
    networkingHelper = NetworkingHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=182f64186d901bf6304b0b4bbbe1264d&units=metric');
    weatherData = await networkingHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
