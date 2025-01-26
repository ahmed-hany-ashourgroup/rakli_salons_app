import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';

part 'book_appointment_state.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  BookAppointmentCubit() : super(BookAppointmentInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> bookAppointment({
    required int businessId,
    required List<int> serviceIds,
    required String startTime,
  }) async {
    emit(BookAppointmentLoading());
    try {
      final response = await _apiService.post(
        'bookings',
        data: {
          'business_id': businessId,
          'service_id': serviceIds,
          'start_time': startTime,
        },
      );
      if (response['success'] == true) {
        emit(BookAppointmentSuccess());
      } else {
        emit(BookAppointmentFailed(errMessage: response['message']));
      }
    } catch (e) {
      emit(BookAppointmentFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
