class WeatherModel {
  final double temp;
  final String description;

  WeatherModel({required this.temp, required this.description});

  WeatherModel.empty()
      : temp = 0,
        description = '';

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    String getDescription(int i) {
      String description = '';
      switch (i) {
        case 0:
          description = 'Clear sky';
          break;
        case 1:
          description = 'Mainly clear';
          break;
        case 2:
          description = 'Partly cloudy';
          break;
        case 3:
          description = 'Overcast';
          break;
        case 45:
          description = 'Fog';
          break;
        case 48:
          description = 'Depositing rime fog';
          break;
        case 51 | 53 | 55:
          description = 'Drizzle';
          break;
        case 56 | 57:
          description = 'Freezing Drizzle';
          break;
        case 61 | 63 | 65:
          description = 'Rain';
          break;
        case 66 | 67:
          description = 'Freezing Rain';
          break;
        case 71 | 73 | 75:
          description = 'Snow fall';
          break;
        case 77:
          description = 'Snow grains';
          break;
        case 80 | 81 | 82:
          description = 'Rain showers';
          break;
        case 85 | 86:
          description = 'Snow showers sligh';
          break;
        case 95:
          description = 'Thunderstorm';
          break;
      }
      return description;
    }

    return WeatherModel(
      temp: json['hourly']['temperature_2m'][0],
      description: getDescription(json['hourly']['weathercode'][0]),
    );
  }
}
