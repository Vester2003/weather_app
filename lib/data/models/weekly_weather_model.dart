import 'package:flutter/material.dart';

class WeeklyWeatherModel {
  final List<dynamic> tempMax;
  final List<dynamic> tempMin;
  final List<IconData> weatherIcon;

  WeeklyWeatherModel(
      {required this.tempMax,
      required this.tempMin,
      required this.weatherIcon});
  WeeklyWeatherModel.empty()
      : tempMax = [],
        tempMin = [],
        weatherIcon = [];

  factory WeeklyWeatherModel.fromJson(Map<String, dynamic> json) {
    List<IconData> getIcon(List<dynamic> weatherCode) {
      List<IconData> iconWeather = [];
      for (int i = 0; i < weatherCode.length; i++) {
        switch (i) {
          case 0:
            iconWeather.add(Icons.light_mode);
            break;
          case 1:
            iconWeather.add(Icons.wb_cloudy);
            break;
          case 2:
            iconWeather.add(Icons.wb_cloudy);
            break;
          case 3:
            iconWeather.add(Icons.wb_cloudy);
            break;
          case 45:
            iconWeather.add(Icons.water);
            break;
          case 48:
            iconWeather.add(Icons.water);
            break;
          case 51:
            iconWeather.add(Icons.thunderstorm);
            break;
          case 53:
            iconWeather.add(Icons.thunderstorm);
            break;
          case 55:
            iconWeather.add(Icons.thunderstorm);
            break;
          case 56:
            iconWeather.add(Icons.thunderstorm);
            break;
          case 57:
            iconWeather.add(Icons.thunderstorm);
            break;
          case 61:
            iconWeather.add(Icons.water_drop);
            break;
          case 63:
            iconWeather.add(Icons.water_drop);
            break;
          case 65:
            iconWeather.add(Icons.water_drop);
            break;
          case 66:
            iconWeather.add(Icons.water_drop);
            break;
          case 67:
            iconWeather.add(Icons.water_drop);
            break;
          case 71:
            iconWeather.add(Icons.ac_unit);
            break;
          case 73 | 75 | 77:
            iconWeather.add(Icons.snowing);
            break;
          case 80 | 81 | 82 | 85 | 86:
            iconWeather.add(Icons.shower);
            break;
          default:
            iconWeather.add(Icons.ac_unit);
            break;
        }
      }
      return iconWeather;
    }

    return WeeklyWeatherModel(
      tempMax: json['daily']['temperature_2m_max'],
      tempMin: json['daily']['temperature_2m_min'],
      weatherIcon: getIcon(json['daily']['weathercode']),
    );
  }
}
