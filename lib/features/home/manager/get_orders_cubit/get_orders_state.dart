part of 'get_orders_cubit.dart';

@immutable
abstract class GetOrdersState {}

class GetOrdersInitial extends GetOrdersState {}

class GetOrdersLoading extends GetOrdersState {}

class GetOrdersSuccess extends GetOrdersState {
  final List<OrderModel> orders;

  GetOrdersSuccess({required this.orders});
}

class GetOrdersFailed extends GetOrdersState {
  final String errMessage;

  GetOrdersFailed({required this.errMessage});
}
