import 'package:flutter/material.dart';
import 'package:weather_apple/data/models/weekly_weather_model.dart';

class WeeklyWeatherWidget extends StatefulWidget {
  final WeeklyWeatherModel weeklyWeatherModel;

  const WeeklyWeatherWidget({super.key, required this.weeklyWeatherModel});

  @override
  State<WeeklyWeatherWidget> createState() => WeeklyWeatherWidgetState();
}

class WeeklyWeatherWidgetState extends State<WeeklyWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 357,
      width: 370,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(30),
      ),
      child: weeklyWeatherCard(widget.weeklyWeatherModel),
    );
  }

  Widget weeklyWeatherCard(WeeklyWeatherModel weeklyWeatherModel) {
    DateTime now = DateTime.now();
    int numberDayWeek = now.weekday;

    getDay(int numberDayWeek) {
      String weekDay = '';
      switch (numberDayWeek) {
        case 1:
          weekDay = 'Monday';
          break;
        case 2:
          weekDay = 'Tuesday';
          break;
        case 3:
          weekDay = 'Wednesday';
          break;
        case 4:
          weekDay = 'Thursday';
          break;
        case 5:
          weekDay = 'Friday';
          break;
        case 6:
          weekDay = 'Saturday';
          break;
        case 7:
          weekDay = 'Sunday';
          break;
      }
      return weekDay;
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 7,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100 + 10,
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      getDay(numberDayWeek + index < 8
                          ? numberDayWeek + index
                          : numberDayWeek + index - 7),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 50,
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      weeklyWeatherModel.weatherIcon[index],
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 160 - 10,
                  height: 50,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${weeklyWeatherModel.tempMin[index].round()}°C/${weeklyWeatherModel.tempMax[index].round()}°C',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
