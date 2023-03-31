import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_apple/data/models/city_model.dart';
import 'package:weather_apple/data/repositories/cities_local_source.dart';
import 'package:weather_apple/data/repositories/geo_repository.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  final CitiesLocalSource citiesLocalSource;
  final GeoRepository geoRepository;
  late List<CityModel> cityModel;
  late List<CityModel> enabledModels;

  SearchCubit({required this.citiesLocalSource, required this.geoRepository})
      : super(SearchCubitInit());

  loadSearchScreen() async {
    emit(SearchCubitLoading());
    try {
      cityModel = await citiesLocalSource.getSavedCities();
      enabledModels = await citiesLocalSource.getEnabledCities();
      emit(SearchCubitLoaded(
          cityModel: cityModel, enabledModels: enabledModels));
    } catch (e) {
      emit(SearchCubitError(message: e.toString()));
    }
  }

  addCity(String cityName) async {
    try {
      final location = await geoRepository.getCityCoordinates(cityName);
      CityModel cityModel = CityModel(name: cityName, location: location);
      await citiesLocalSource.saveCities(cityModel);
      await loadSearchScreen();
    } catch (e) {
      emit(SearchCubitError(message: e.toString()));
    }
  }

  enableCity(CityModel cityModel) async {
    await citiesLocalSource.saveEnabledCities(cityModel);
  }

  disableCity(CityModel cityModel) async {
    await citiesLocalSource.removeEnabledCities(cityModel);
  }

  dispose() {
    emit(SearchCubitInit());
  }
}
