part of 'get_my_products_cubit.dart';

@immutable
sealed class GetMyProductsState {}

final class GetMyProductsInitial extends GetMyProductsState {}

final class GetMyProductsLoading extends GetMyProductsState {}

final class GetMyProductsSuccess extends GetMyProductsState {
  final List<ProductModel> products;

  GetMyProductsSuccess({required this.products});
}

final class GetMyProductsFailed extends GetMyProductsState {
  final String errMessage;

  GetMyProductsFailed({required this.errMessage});
}
