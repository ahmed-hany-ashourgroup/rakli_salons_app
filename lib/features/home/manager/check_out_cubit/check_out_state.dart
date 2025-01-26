part of 'check_out_cubit.dart';

@immutable
sealed class CheckOutState {}

final class CheckOutInitial extends CheckOutState {}

final class CheckOutLoading extends CheckOutState {}

final class CheckOutSuccess extends CheckOutState {
  final CheckoutDataModel checkOutModel;
  CheckOutSuccess({required this.checkOutModel});
}

final class CheckOutFailed extends CheckOutState {
  final String errMessage;
  CheckOutFailed({required this.errMessage});
}
