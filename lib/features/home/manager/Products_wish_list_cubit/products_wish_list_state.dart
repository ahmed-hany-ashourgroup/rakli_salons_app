part of 'products_wish_list_cubit.dart';

abstract class ProductsWishListState extends Equatable {
  const ProductsWishListState();

  @override
  List<Object> get props => [];
}

class ProductsWishListInitial extends ProductsWishListState {}

class ProductsWishListLoading extends ProductsWishListState {}

class ProductsWishListSuccess extends ProductsWishListState {}

class ProductsWishListLoaded extends ProductsWishListState {
  final List<ProductModel> products;

  const ProductsWishListLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsWishListFailed extends ProductsWishListState {
  final String errMessage;

  const ProductsWishListFailed({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
