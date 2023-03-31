part of 'search_cubit.dart';

abstract class SearchCubitState {}

class SearchCubitInit extends SearchCubitState {}

class SearchCubitLoaded extends SearchCubitState {
  final List<CityModel> cityModel;
  final List<CityModel> enabledModels;

  SearchCubitLoaded({required this.cityModel, required this.enabledModels});
}

class SearchCubitLoading extends SearchCubitState {}

class SearchCubitError extends SearchCubitState {
  final String message;

  SearchCubitError({required this.message});
}
