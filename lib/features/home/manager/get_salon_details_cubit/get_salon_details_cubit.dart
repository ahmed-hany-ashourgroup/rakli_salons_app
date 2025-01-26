import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/salon_model.dart';

part 'get_salon_details_state.dart';

class GetSalonDetailsCubit extends Cubit<GetSalonDetailsState> {
  GetSalonDetailsCubit() : super(GetSalonDetailsInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> getSalonDetails(String salonId) async {
    emit(GetSalonDetailsLoading());
    try {
      final response = await _apiService.get('business/$salonId');
      final salon =
          SalonModel.fromJson(response['data']); // Parse the salon data
      emit(GetSalonDetailsSuccess(salon)); // Emit success state with salon data
    } catch (e) {
      emit(GetSalonDetailsFailed(
          _apiService.handleDioError(e.toString()).message));
    }
  }
}
