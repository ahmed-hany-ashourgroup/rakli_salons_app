part of 'products_wish_list_cubit.dart';

sealed class ProductsWishListState extends Equatable {
  const ProductsWishListState();

  @override
  List<Object> get props => [];
}

final class ProductsWishListInitial extends ProductsWishListState {}

final class ProductsWishListLoading extends ProductsWishListState {}

final class ProductsWishListSuccess extends ProductsWishListState {}

final class ProductsWishListLoaded extends ProductsWishListState {
  final List<ProductModel> products;

  const ProductsWishListLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class ProductsWishListFailed extends ProductsWishListState {
  final String errMessage;
  const ProductsWishListFailed({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
