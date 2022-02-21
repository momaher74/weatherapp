import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled1/helpers/dio.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  double? minTemp;

  double? maxTemp;
  double? theTemp;

  String ? stateName ;
  String ? date ;
  int? cityId;

  getWoeId({
    required String? city,
  }) {
    emit(GetIdLoadingState());

    DioHelper.getData(
      url: 'api/location/search/?query=$city',
    ).then((value) {
      cityId = value.data[0]['woeid'];
      print(cityId);
      getWeather();
      // emit(GetIdSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetIdErrorState());
    });
  }

  getWeather() {
    emit(GetWeatherLoadingState());
    DioHelper.getData(
      url: 'api/location/$cityId',
    ).then((value) {
      // max_temp min_temp  the_temp  applicable_date
     // int id = value.data['consolidated_weather'][0]['id'] ;
     //  print(value.data) ;
     minTemp = value.data['consolidated_weather'][0]['min_temp'] ;
     maxTemp = value.data['consolidated_weather'][0]['max_temp'] ;
     theTemp = value.data['consolidated_weather'][0]['the_temp'] ;
     stateName = value.data['consolidated_weather'][0]['weather_state_name'] ;
     date = value.data['consolidated_weather'][0]['applicable_date'] ;
      emit(GetWeatherSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetWeatherErrorState());
    });
  }
}
//['woeid']['consolidated_weather'][0]['id']
