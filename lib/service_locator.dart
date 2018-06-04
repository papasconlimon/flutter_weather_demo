import 'package:flutter_weather_demo/app_model.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_weather_demo/services/weather_api.dart';
import 'package:flutter_weather_demo/services/weather_api_open_weather_map.dart';

// ambient variable to access the service locator
GetIt sl = new GetIt();

void setup() {
      // Important to register services that might be used in AppModel constructor first
      sl.registerSingleton<WeatherAPI>(new WeatherAPIOpenWeatherMap() );
      sl.registerSingleton<AppModel>(new AppModel());
}