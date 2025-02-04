import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';

part 'products_wish_list_state.dart';

class ProductsWishListCubit extends Cubit<ProductsWishListState> {
  ProductsWishListCubit() : super(ProductsWishListInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  // Keep track of products in wishlist
  List<ProductModel> _wishlistProducts = [];

  List<ProductModel> get wishlistProducts => _wishlistProducts;

  bool isProductInWishlist(int productId) {
    return _wishlistProducts.any((product) => product.id == productId);
  }

  Future<bool> addProductsToWishlist(int productId) async {
    try {
      final response = await _apiService.post(
        'wishlist-product/add',
        data: {
          'product_item': [productId],
        },
      );

      if (response['success'] == true) {
        // Add the product to local list if it's not already there
        if (!isProductInWishlist(productId)) {
          // Optimistically update the state
          final product = ProductModel(id: productId);
          _wishlistProducts.add(product);
          emit(ProductsWishListLoaded(_wishlistProducts));

          // Then fetch the full product details
          try {
            final productResponse =
                await _apiService.get('products/$productId');
            if (productResponse['success'] == true) {
              final updatedProduct =
                  ProductModel.fromJson(productResponse['data']);
              // Update the product in the list with full details
              final index =
                  _wishlistProducts.indexWhere((p) => p.id == productId);
              if (index != -1) {
                _wishlistProducts[index] = updatedProduct;
                emit(ProductsWishListLoaded(_wishlistProducts));
              }
            }
          } catch (e) {
            // If fetching details fails, we still keep the basic product in the list
            print('Failed to fetch product details: $e');
          }
        }
        return true;
      } else {
        emit(ProductsWishListFailed(
            errMessage:
                response['message'] ?? 'Failed to add product to wishlist'));
        return false;
      }
    } catch (e) {
      emit(ProductsWishListFailed(errMessage: e.toString()));
      return false;
    }
  }

  Future<bool> removeFromWishlist(int productId) async {
    try {
      // Optimistically remove from local state
      final removedProduct =
          _wishlistProducts.firstWhere((p) => p.id == productId);
      _wishlistProducts.removeWhere((product) => product.id == productId);
      emit(ProductsWishListLoaded(_wishlistProducts));

      final response = await _apiService.delete(
        'wishlist-product/delete',
        data: {
          'product_item': [productId],
        },
      );

      if (response['success'] == true) {
        return true;
      } else {
        // If the API call fails, revert the local change
        _wishlistProducts.add(removedProduct);
        emit(ProductsWishListLoaded(_wishlistProducts));
        emit(ProductsWishListFailed(
            errMessage:
                response['message'] ?? 'Failed to remove from wishlist'));
        return false;
      }
    } catch (e) {
      emit(ProductsWishListFailed(errMessage: e.toString()));
      return false;
    }
  }

  Future<void> getProductsWishlist() async {
    emit(ProductsWishListLoading());
    try {
      final response = await _apiService.get('wishlist-product');

      if (response['success'] == true) {
        _wishlistProducts = (response['data']['products'] as List)
            .map((product) => ProductModel.fromJson(product))
            .toList();
        emit(ProductsWishListLoaded(_wishlistProducts));
      } else {
        emit(ProductsWishListFailed(
            errMessage: response['message'] ?? 'Failed to fetch wishlist'));
      }
    } catch (e) {
      emit(ProductsWishListFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }

  // Toggle wishlist status
  Future<bool> toggleWishlistStatus(int productId) async {
    final bool isInWishlist = isProductInWishlist(productId);
    if (isInWishlist) {
      return await removeFromWishlist(productId);
    } else {
      return await addProductsToWishlist(productId);
    }
  }
}
