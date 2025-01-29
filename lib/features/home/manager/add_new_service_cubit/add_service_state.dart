// add_service_state.dart
part of 'add_service_cubit.dart';

@immutable
sealed class AddServiceState {}

final class AddServiceInitial extends AddServiceState {}

final class AddServiceLoading extends AddServiceState {}

final class AddServiceSuccess extends AddServiceState {
  final String message;
  AddServiceSuccess({required this.message});
}

final class AddServiceFailure extends AddServiceState {
  final String error;
  AddServiceFailure({required this.error});
}
