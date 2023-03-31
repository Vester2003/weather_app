import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:weather_apple/data/models/hourly_weather_model.dart';
import 'package:weather_apple/data/models/weather_model.dart';
import 'package:weather_apple/data/models/weekly_weather_model.dart';

abstract class WeatherApi {
  Future<WeatherModel> fetchCurrentWeather(Location position);
  Future<HourlyWeatherModel> fetchHourlyWeather(Location position);
  Future<WeeklyWeatherModel> fetchWeeklyWeather(
      DateTime current, DateTime weekLater, Location position);
}

class WeatherApiImpl implements WeatherApi {
  @override
  Future<WeatherModel> fetchCurrentWeather(Location position) async {
    final response = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&hourly=temperature_2m,weathercode&timezone=Europe%2FMoscow'));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    }
    return WeatherModel.empty();
  }

  @override
  Future<HourlyWeatherModel> fetchHourlyWeather(Location position) async {
    final response = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&hourly=temperature_2m,weathercode&timezone=Europe%2FMoscow'));

    if (response.statusCode == 200) {
      return HourlyWeatherModel.fromJson(jsonDecode(response.body));
    }
    return HourlyWeatherModel.empty();
  }

  @override
  Future<WeeklyWeatherModel> fetchWeeklyWeather(
      DateTime current, DateTime weekLater, Location position) async {
    final response = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&daily=weathercode,temperature_2m_max,temperature_2m_min&timezone=Europe%2FMoscow&'
        'start_date=${current.year}-${current.month < 10 ? '0${current.month}' : '${current.month}'}-${current.day < 10 ? '0${current.day}' : '${current.day}'}&'
        'end_date=${weekLater.year}-${weekLater.month < 10 ? '0${weekLater.month}' : '${weekLater.month}'}-${weekLater.day < 10 ? '0${weekLater.day}' : '${weekLater.day}'}'));

    if (response.statusCode == 200) {
      return WeeklyWeatherModel.fromJson(jsonDecode(response.body));
    }
    return WeeklyWeatherModel.empty();
  }
}
