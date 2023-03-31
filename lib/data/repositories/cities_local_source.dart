import 'dart:developer' as dev;

import 'package:get_storage/get_storage.dart';
import 'package:weather_apple/data/models/city_model.dart';

abstract class CitiesLocalSource {
  Future<List<CityModel>> getSavedCities();
  Future<List<CityModel>> getEnabledCities();
  Future<bool> saveCities(CityModel cityModel);
  Future<bool> saveEnabledCities(CityModel cityModel);
  Future<bool> removeEnabledCities(CityModel cityModel);
}

class CitiesLocalSourceImpl implements CitiesLocalSource {
  final GetStorage getStorage;
  final String _cityKey = 'savedCities';
  final String _enabledKey = 'enabledCities';

  CitiesLocalSourceImpl({required this.getStorage});

  @override
  Future<List<CityModel>> getEnabledCities() async {
    final data = await getStorage.read(_enabledKey);
    if (data != null) {
      return data.map((e) => CityModel.fromJson(e)).cast<CityModel>().toList();
    }
    return [];
  }

  @override
  Future<List<CityModel>> getSavedCities() async {
    final data = await getStorage.read(_cityKey);

    try {
      if (data != null) {
        return data
            .map((e) => CityModel.fromJson(e))
            .cast<CityModel>()
            .toList();
      }
    } catch (e) {
      dev.log(e.toString());
    }
    return [];
  }

  @override
  Future<bool> saveCities(CityModel cityModel) async {
    final data = await getStorage.read(_cityKey);
    if (data != null) {
      data.add(cityModel.toJson());
      getStorage.write(_cityKey, data);

      return true;
    }
    getStorage.write(_cityKey, [cityModel.toJson()]);

    return true;
  }

  @override
  Future<bool> saveEnabledCities(CityModel cityModel) async {
    final data = await getStorage.read(_enabledKey);
    if (data != null) {
      data.add(cityModel.toJson());
      getStorage.write(_enabledKey, data);

      return true;
    }
    getStorage.write(_enabledKey, [cityModel.toJson()]);

    return true;
  }

  @override
  Future<bool> removeEnabledCities(CityModel cityModel) async {
    final data = await getStorage.read(_enabledKey);
    final dataList =
        data.map((e) => CityModel.fromJson(e)).cast<CityModel>().toList();
    for (int i = 0; i < dataList.length; ++i) {
      if (dataList[i] == cityModel) {
        getStorage.remove(_enabledKey);
        dataList.removeAt(i);
        if (dataList.length == 0) {
          return true;
        }
        getStorage.write(_enabledKey, dataList);
        return true;
      }
    }
    return true;
  }
}
