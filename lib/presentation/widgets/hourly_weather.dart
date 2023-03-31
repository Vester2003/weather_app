import 'package:flutter/material.dart';
import 'package:weather_apple/data/models/hourly_weather_model.dart';

class HourlyWeather extends StatefulWidget {
  final HourlyWeatherModel hourWeatherModel;

  const HourlyWeather({super.key, required this.hourWeatherModel});

  @override
  State<HourlyWeather> createState() => HourlyWeatherState();
}

class HourlyWeatherState extends State<HourlyWeather> {
  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 50),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.transparent,
      ),
      child: hourWeather(widget.hourWeatherModel),
    );
  }

  Widget hourWeather(HourlyWeatherModel hourWeatherModel) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          width: 60,
          height: 130,
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
          ),
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black26,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time.hour + index < 24
                    ? '${time.hour + index}'
                    : '${time.hour + index - 24}',
                style: const TextStyle(color: Colors.white),
              ),
              Icon(
                hourWeatherModel.weatherIcon[index],
                color: Colors.white,
              ),
              Text(
                hourWeatherModel.tempH[index].round().toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
