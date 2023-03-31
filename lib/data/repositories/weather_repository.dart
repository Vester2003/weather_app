import 'package:geocoding/geocoding.dart';
import 'package:weather_apple/data/api/weather_api.dart';
import 'package:weather_apple/data/models/hourly_weather_model.dart';
import 'package:weather_apple/data/models/weather_model.dart';
import 'package:weather_apple/data/models/weekly_weather_model.dart';
import 'package:weather_apple/data/repositories/geo_repository.dart';

abstract class WeatherRepository {
  Future<WeatherModel> fetchCurrentWeather(Location position);
  Future<HourlyWeatherModel> fetchHourlyWeather(Location position);
  Future<WeeklyWeatherModel> fetchWeeklyWeather(Location position);
}

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApi weatherApi;
  final GeoRepository geoRepository;

  WeatherRepositoryImpl(
      {required this.weatherApi, required this.geoRepository});

  @override
  Future<WeatherModel> fetchCurrentWeather(Location position) async {
    return await weatherApi.fetchCurrentWeather(position);
  }

  @override
  Future<HourlyWeatherModel> fetchHourlyWeather(Location position) async {
    return await weatherApi.fetchHourlyWeather(position);
  }

  @override
  Future<WeeklyWeatherModel> fetchWeeklyWeather(Location position) async {
    DateTime current = DateTime.now();
    DateTime weekLater = current.add(const Duration(days: 6));
    return await weatherApi.fetchWeeklyWeather(current, weekLater, position);
  }
}
