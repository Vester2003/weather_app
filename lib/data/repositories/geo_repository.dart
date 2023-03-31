import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_apple/data/repositories/cities_local_source.dart';

abstract class GeoRepository {
  Future<Location> getCityCoordinates(String cityName);
  Future<Location> getLocation();
  Future<String> getCityName();
  Future requestPermission();
}

class GeoRepositoryImpl implements GeoRepository {
  final CitiesLocalSource citiesLocalSource;
  GeoRepositoryImpl({required this.citiesLocalSource});

  @override
  Future<Location> getCityCoordinates(String cityName) async {
    List<Location> locations = await locationFromAddress(cityName);
    return locations[0];
  }

  @override
  Future<Location> getLocation() async {
    Location location;
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      location = Location(
          latitude: position.latitude,
          longitude: position.longitude,
          timestamp: DateTime.now());
      return location;
    }
    return Location(
      longitude: 12,
      latitude: 12,
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<String> getCityName() async {
    Location position = await getLocation();
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemark[0].administrativeArea!;
  }

  @override
  Future requestPermission() async {
    await Geolocator.requestPermission();
  }
}
