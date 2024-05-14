import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_api/Models/weather_model.dart';

class Repo{
    getWeather(String? city) async{
      var url = "https://api.weatherapi.com/v1/current.json?q=$city&key=fcb978267aa94bc18db74842241305";
      
     final res = await http.get(Uri.parse(url));

     var resBody = res.body;

     if(res.statusCode==200){
       return WeatherModel.fromJson(json.decode(resBody));
     }
     throw Exception();
    }
}
