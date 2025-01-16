part of 'log_out_cubit.dart';

@immutable
sealed class LogOutState {}

final class LogOutInitial extends LogOutState {}

final class LogOutLoading extends LogOutState {}

final class LogOutSuccess extends LogOutState {}

final class LogOutFailed extends LogOutState {
  final String errMessage;

  LogOutFailed({required this.errMessage});
}
