part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class GetWeatherLoadingState extends AppState {}

class GetWeatherSuccessState extends AppState {}

class GetWeatherErrorState extends AppState {}

class GetIdLoadingState extends AppState {}

class GetIdSuccessState extends AppState {}

class GetIdErrorState extends AppState {}
