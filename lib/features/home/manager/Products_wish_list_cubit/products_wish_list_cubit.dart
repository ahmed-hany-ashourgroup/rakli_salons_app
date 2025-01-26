import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';

part 'products_wish_list_state.dart';

class ProductsWishListCubit extends Cubit<ProductsWishListState> {
  ProductsWishListCubit() : super(ProductsWishListInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> addProductsToWishlist(List<int> productItems) async {
    emit(ProductsWishListLoading());
    try {
      final response = await _apiService.post(
        'wishlist-product/add',
        data: {
          'product_items': productItems,
        },
      );

      if (response['success'] == true) {
        emit(ProductsWishListSuccess());
      } else {
        emit(ProductsWishListFailed(
            errMessage:
                response['message'] ?? 'Failed to add products to wishlist'));
      }
    } catch (e) {
      emit(ProductsWishListFailed(errMessage: e.toString()));
    }
  }

  Future<void> getProductsWishlist() async {
    emit(ProductsWishListLoading());
    try {
      final response = await _apiService.get('wishlist-product');

      if (response['success'] == true) {
        final List<ProductModel> products =
            (response['data']['products'] as List)
                .map((product) => ProductModel.fromJson(product))
                .toList();
        emit(ProductsWishListLoaded(products));
      } else {
        emit(ProductsWishListFailed(
            errMessage: response['message'] ?? 'Failed to fetch wishlist'));
      }
    } catch (e) {
      emit(ProductsWishListFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
