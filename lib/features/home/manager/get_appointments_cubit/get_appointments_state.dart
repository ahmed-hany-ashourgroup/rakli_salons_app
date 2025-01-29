part of 'get_appointments_cubit.dart';

@immutable
sealed class GetAppointmentsState {}

final class GetAppointmentsInitial extends GetAppointmentsState {}

final class GetAppointmentsLoading extends GetAppointmentsState {}

final class GetAppointmentsSuccess extends GetAppointmentsState {
  final List<AppointmentsModel> appointments;
  GetAppointmentsSuccess({required this.appointments});
}

final class GetAppointmentsFailed extends GetAppointmentsState {
  final String errMessage;
  GetAppointmentsFailed({required this.errMessage});
}
