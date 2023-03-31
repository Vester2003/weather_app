import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_apple/data/api/weather_api.dart';
import 'package:weather_apple/data/repositories/repositories.dart';
import 'package:weather_apple/presentation/bloc/main/main_cubit.dart';
import 'package:weather_apple/presentation/bloc/search/search_cubit.dart';

final getIt = GetIt.instance;

init() async {
  final storageBox = GetStorage();
  await GetStorage.init();
  getIt.registerLazySingleton(() => storageBox);
  initApi();
  initRepos();
  initCubits();
}

initRepos() {
  getIt.registerLazySingleton<CitiesLocalSource>(
      () => CitiesLocalSourceImpl(getStorage: getIt()));
  getIt.registerLazySingleton<GeoRepository>(
      () => GeoRepositoryImpl(citiesLocalSource: getIt()));
  getIt.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(weatherApi: getIt(), geoRepository: getIt()));
}

initApi() {
  getIt.registerLazySingleton<WeatherApi>(() => WeatherApiImpl());
}

initCubits() {
  getIt.registerFactory<MainCubit>(() => MainCubit(
      weatherRepository: getIt(),
      geoRepository: getIt(),
      citiesLocalSource: getIt()));
  getIt.registerFactory<SearchCubit>(
      () => SearchCubit(citiesLocalSource: getIt(), geoRepository: getIt()));
}
