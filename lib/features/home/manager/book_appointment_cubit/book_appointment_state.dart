part of 'book_appointment_cubit.dart';

@immutable
sealed class BookAppointmentState {}

final class BookAppointmentInitial extends BookAppointmentState {}

final class BookAppointmentLoading extends BookAppointmentState {}

final class BookAppointmentSuccess extends BookAppointmentState {}

final class BookAppointmentFailed extends BookAppointmentState {
  final String errMessage;

  BookAppointmentFailed({required this.errMessage});
}
