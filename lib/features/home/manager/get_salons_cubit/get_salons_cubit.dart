import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/salon_model.dart';

part 'get_salons_state.dart';

class GetSalonsCubit extends Cubit<GetSalonsState> {
  GetSalonsCubit() : super(GetSalonsInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> getAllSalons() async {
    emit(GetSalonsLoading());
    try {
      final response = await _apiService.get('business/get/salon');

      // Extract the 'data' field from the response
      final List<dynamic> data = response['data']['data'];

      // Convert each item in 'data' to a SalonModel object
      final List<SalonModel> salons =
          data.map((json) => SalonModel.fromJson(json)).toList();

      emit(GetSalonsSuccess(salons: salons));
    } catch (e) {
      emit(GetSalonsFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }

  Future<void> getTopRatedSalons() async {
    emit(GetSalonsLoading());
    try {
      final response = await _apiService.get('businesses/top-rated/salons');

      // Extract the 'data' field from the response
      final List<dynamic> data = response['data'];

      // Convert each item in 'data' to a SalonModel object
      final List<SalonModel> salons =
          data.map((json) => SalonModel.fromJson(json)).toList();
      Logger.info('Salons: $salons');

      emit(GetSalonsSuccess(salons: salons));
    } catch (e) {
      emit(GetSalonsFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
