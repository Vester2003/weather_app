import 'package:weather_apple/data/models/hourly_weather_model.dart';
import 'package:weather_apple/data/models/weather_model.dart';
import 'package:weather_apple/data/models/weekly_weather_model.dart';

class PageModel {
  final String name;
  final WeatherModel weatherModel;
  final HourlyWeatherModel hourlyWeatherModel;
  final WeeklyWeatherModel weeklyWeatherModel;

  PageModel(
      {required this.name,
      required this.weatherModel,
      required this.hourlyWeatherModel,
      required this.weeklyWeatherModel});
}
