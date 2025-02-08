import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';

part 'update_appointment_state_state.dart';

class UpdateAppointmentStateCubit extends Cubit<UpdateAppointmentStateState> {
  UpdateAppointmentStateCubit() : super(UpdateAppointmentStateInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> updateState({
    required String appointmentId,
    required String state,
  }) async {
    emit(UpdateAppointmentStateLoading());
    try {
      final response = await _apiService.put(
        'orders/orders/$appointmentId/state',
        data: {'state': state},
      );

      if (response['success'] == true) {
        emit(UpdateAppointmentStateSuccess());
      } else {
        emit(UpdateAppointmentStateFailed(
          errMessage:
              response['message'] ?? 'Failed to update appointment state',
        ));
      }
    } catch (e) {
      emit(UpdateAppointmentStateFailed(
        errMessage: _apiService.handleDioError(e.toString()).message,
      ));
    }
  }
}
