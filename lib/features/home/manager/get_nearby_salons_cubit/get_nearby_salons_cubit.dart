import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/salon_model.dart';

part 'get_nearby_salons_state.dart';

class GetNearbySalonsCubit extends Cubit<GetNearbySalonsState> {
  GetNearbySalonsCubit() : super(GetNearbySalonsInitial());
  final _apiService = getIt.get<ApiService>();

  Future<void> getNearbySalons(
      {required double latitude, required double longitude}) async {
    emit(GetNearbySalonsLoading());
    try {
      final response = await _apiService.post(
        'nearby-businesses',
        data: {
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      if (response['success'] == true) {
        final List<SalonModel> salons = (response['data'] as List)
            .map((salon) => SalonModel.fromJson(salon))
            .toList();
        emit(GetNearbySalonsSuccess(salons: salons));
      } else {
        emit(GetNearbySalonsFailed(
            errMessage: response['message'] ?? 'Failed to load nearby salons'));
      }
    } catch (e) {
      emit(GetNearbySalonsFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
