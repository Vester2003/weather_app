import 'package:geocoding/geocoding.dart';

class CityModel {
  final String name;
  final Location location;

  CityModel({required this.name, required this.location});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    final splittedLocation = json['location'].toString().split(',');
    final location = Location(
        latitude: double.parse(splittedLocation[0].split('Latitude: ')[1]),
        longitude: double.parse(splittedLocation[1].split('Longitude: ')[1]),
        timestamp: DateTime.now());
    return CityModel(name: json['name'], location: location);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'location': location.toString(),
      };

  @override
  bool operator ==(Object other) {
    return other is CityModel &&
        other.name == name &&
        other.runtimeType == runtimeType;
  }

  @override
  int get hashCode => Object.hash(name, runtimeType);
}
