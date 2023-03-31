import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_apple/data/models/page_model.dart';
import 'package:weather_apple/data/repositories/cities_local_source.dart';
import 'package:weather_apple/data/repositories/geo_repository.dart';
import 'package:weather_apple/data/repositories/weather_repository.dart';

part 'main_cubit_state.dart';

class MainCubit extends Cubit<MainCubitState> {
  final WeatherRepository weatherRepository;
  final GeoRepository geoRepository;
  final CitiesLocalSource citiesLocalSource;
  List<PageModel> pageModels = [];

  MainCubit(
      {required this.weatherRepository,
      required this.geoRepository,
      required this.citiesLocalSource})
      : super(MainCubitInit());

  loadHomeScreen() async {
    emit(MainCubitLoading());
    try {
      await geoRepository.requestPermission();
      final location = await geoRepository.getLocation();
      pageModels = [
        PageModel(
          weatherModel: await weatherRepository.fetchCurrentWeather(location),
          hourlyWeatherModel:
              await weatherRepository.fetchHourlyWeather(location),
          weeklyWeatherModel:
              await weatherRepository.fetchWeeklyWeather(location),
          name: await geoRepository.getCityName(),
        ),
      ];
      await loadSavedScreens();
    } catch (e) {
      emit(MainCubitError(message: e.toString()));
    }
  }

  loadSavedScreens() async {
    try {
      final listCityModels = await citiesLocalSource.getEnabledCities();
      for (int i = 0; i < listCityModels.length; i++) {
        final name = listCityModels[i].name;
        final location = listCityModels[i].location;
        final page = PageModel(
          weatherModel: await weatherRepository.fetchCurrentWeather(location),
          hourlyWeatherModel:
              await weatherRepository.fetchHourlyWeather(location),
          weeklyWeatherModel:
              await weatherRepository.fetchWeeklyWeather(location),
          name: name,
        );
        pageModels.add(page);
      }
      emit(MainCubitLoaded(pageModel: pageModels));
    } catch (e) {
      emit(MainCubitError(message: e.toString()));
    }
  }
}
