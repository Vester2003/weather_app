part of 'main_cubit.dart';

abstract class MainCubitState {}

class MainCubitInit extends MainCubitState {}

class MainCubitLoaded extends MainCubitState {
  final List<PageModel> pageModel;

  MainCubitLoaded({required this.pageModel});
}

class MainCubitLoading extends MainCubitState {}

class MainCubitError extends MainCubitState {
  final String message;

  MainCubitError({required this.message});
}
