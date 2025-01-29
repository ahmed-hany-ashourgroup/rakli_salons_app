import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/features/home/data/models/appointment_model.dart';

part 'get_appointments_state.dart';

class GetAppointmentsCubit extends Cubit<GetAppointmentsState> {
  GetAppointmentsCubit() : super(GetAppointmentsInitial());

  final ApiService _apiService = ApiService();

  Future<void> fetchAppointments() async {
    emit(GetAppointmentsLoading());
    try {
      final response = await _apiService.get('bookings/business');

      // Check if response is Map
      if (response is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      // Check for success status
      if (response['success'] != true) {
        throw Exception(response['message'] ?? 'Failed to fetch appointments');
      }

      // Access the nested data structure correctly
      final responseData = response['data'] as Map<String, dynamic>;
      final appointmentsData = responseData['data'] as List<dynamic>;

      // Convert the appointments data
      final appointments = appointmentsData
          .map((json) =>
              AppointmentsModel.fromJson(json as Map<String, dynamic>))
          .toList();

      emit(GetAppointmentsSuccess(appointments: appointments));
    } catch (e, stacktrace) {
      Logger.error("Fetch Appointments Error: $e\n$stacktrace");
      emit(GetAppointmentsFailed(
          errMessage:
              e is Exception ? e.toString() : 'Failed to fetch appointments'));
    }
  }
}
