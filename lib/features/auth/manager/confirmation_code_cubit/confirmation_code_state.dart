part of 'confirmation_code_cubit.dart';

@immutable
sealed class ConfirmationCodeState {}

final class ConfirmationCodeInitial extends ConfirmationCodeState {}

final class ConfirmationCodeSuccess extends ConfirmationCodeState {
  final BuisnessUserModel user;

  ConfirmationCodeSuccess({required this.user});
}

final class ConfirmationCodeLoading extends ConfirmationCodeState {}

final class ConfirmationCodeFailed extends ConfirmationCodeState {
  final String errMessage;

  ConfirmationCodeFailed({required this.errMessage});
}
