import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_api/Models/weather_model.dart';

class Repo {
  Future<WeatherModel> getWeather(String city) async {
    var url =
        "https://api.weatherapi.com/v1/current.json?q=$city&key=fcb978267aa94bc18db74842241305";

    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(res.body));
    }
    throw Exception();
  }

  Future<WeatherModel> getWeatherByLL(double latitude, double longitude) async {
    var url =
        "https://api.weatherapi.com/v1/current.json?q=$latitude,$longitude&key=fcb978267aa94bc18db74842241305";

    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(res.body));
    }
    throw Exception();
  }
}
