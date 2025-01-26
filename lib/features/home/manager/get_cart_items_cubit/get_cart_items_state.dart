part of 'get_cart_items_cubit.dart';

@immutable
sealed class GetCartItemsState {}

final class GetCartItemsInitial extends GetCartItemsState {}

final class GetCartItemsLoading extends GetCartItemsState {}

final class GetCartItemsSuccess extends GetCartItemsState {
  final CartResponseModel cartResponce;
  GetCartItemsSuccess({required this.cartResponce});
}

final class GetCartItemsFailed extends GetCartItemsState {
  final String errMessage;
  GetCartItemsFailed({required this.errMessage});
}
