import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
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
    Logger.info(state);
    try {
      final response = await _apiService.post(
        'bookings/request-state/$appointmentId',
        data: {
          'request_state': state,
        },
      );

      if (response['success'] == true) {
        final updatedState = response['data']['request_state'] as String;
        emit(UpdateAppointmentStateSuccess(updatedState: updatedState));
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
