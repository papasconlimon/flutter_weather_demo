import 'dart:async';
import 'dart:convert';

import 'package:flutter_weather_demo/app_model.dart';
import 'package:flutter_weather_demo/json/weather_in_cities.dart';
import 'package:flutter_weather_demo/services/weather_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;



class WeatherAPIOpenWeatherMap implements WeatherAPI {
  Stream<List<WeatherEntry>> getWeatherEntries(String filterText) {
    const String url =
        "http://api.openweathermap.org/data/2.5/box/city?bbox=5,47,14,54,20&appid=27ac337102cc4931c24ba0b50aca6bbd";

    var httpStream = new Observable(http.get(url).asStream());

    return httpStream.handleError((error) {
      print("Error");
    }).map((data) {
      if (data.statusCode == 200) {
        print(data.body);
        return new WeatherInCities.fromJson(json.decode(data.body))
            .Cities
            .where((weatherInCity) =>
                filterText.isEmpty || weatherInCity.Name.toUpperCase().startsWith(filterText.toUpperCase()))
            .map((weatherInCity) => new WeatherEntry(weatherInCity))
            .toList();
      } else {
        return null;
      }
    });
  }
}