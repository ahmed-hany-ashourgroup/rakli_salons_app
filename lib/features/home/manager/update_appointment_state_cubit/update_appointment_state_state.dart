part of 'update_appointment_state_cubit.dart';

@immutable
abstract class UpdateAppointmentStateState {}

class UpdateAppointmentStateInitial extends UpdateAppointmentStateState {}

class UpdateAppointmentStateLoading extends UpdateAppointmentStateState {}

class UpdateAppointmentStateSuccess extends UpdateAppointmentStateState {}

class UpdateAppointmentStateFailed extends UpdateAppointmentStateState {
  final String errMessage;

  UpdateAppointmentStateFailed({required this.errMessage});
}
