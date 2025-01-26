import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/add_to_cart_item_model.dart';

part 'add_to_cart_state.dart';

// add_to_cart_cubit.dart
class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> addToCart(AddToCartRequestModel request) async {
    emit(AddToCartLoading());
    try {
      final response = await _apiService.post(
        'cart/add',
        data: request.toJson(),
      );

      if (response['success'] == true) {
        emit(AddToCartSuccess());
      } else {
        emit(AddToCartFailed(
          errMessage: response['message'] ?? 'Failed to add item to cart',
        ));
      }
    } catch (e) {
      emit(AddToCartFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }

  Future<void> removeFromCart({
    required String productId,
    required bool isCollection,
    String? size,
  }) async {
    emit(AddToCartLoading());
    try {
      // Prepare the request body
      final Map<String, dynamic> requestBody = {
        'product_id': productId,
        '_method': 'DELETE',
      };

      // Add 'is_collection' only if the item is a collection
      if (isCollection) {
        requestBody['is_collection'] = true;
      }

      // Add 'size' only if the item is not a collection
      if (!isCollection && size != null) {
        requestBody['size'] = size;
      }

      // Send the request
      final response = await _apiService.post(
        'cart/remove-item',
        data: requestBody,
      );

      if (response['success'] == true) {
        emit(AddToCartSuccess());
      } else {
        emit(AddToCartFailed(
          errMessage: response['message'] ?? 'Failed to remove item from cart',
        ));
      }
    } catch (e) {
      emit(AddToCartFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }

  Future<void> incrementQuantity({
    required String productId,
    required bool isCollection,
    required int currentQuantity,
    String? size,
  }) async {
    emit(AddToCartLoading());
    try {
      // Calculate the new quantity
      final int newQuantity = currentQuantity + 1;

      // Prepare the request body
      final Map<String, dynamic> requestBody = {
        'product_item': {
          'id': productId,
          'quantity': newQuantity,
          'is_collection': isCollection,
          if (!isCollection && size != null) 'size': size,
        },
      };

      // Send the request
      final response = await _apiService.post(
        'cart/update-item',
        data: requestBody,
      );

      if (response['success'] == true) {
        emit(AddToCartSuccess());
      } else {
        emit(AddToCartFailed(
          errMessage: response['message'] ?? 'Failed to increment quantity',
        ));
      }
    } catch (e) {
      emit(AddToCartFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }

  Future<void> decrementQuantity({
    required num productId,
    required bool isCollection,
    required int currentQuantity,
    String? size,
  }) async {
    emit(AddToCartLoading());
    try {
      // Prevent quantity from going below 1
      if (currentQuantity <= 1) {
        emit(AddToCartFailed(errMessage: 'Minimum quantity is 1'));
        return;
      }

      // Calculate the new quantity
      final int newQuantity = currentQuantity - 1;

      // Prepare the request body
      final Map<String, dynamic> requestBody = {
        'product_item': {
          'id': productId,
          'quantity': newQuantity,
          'is_collection': isCollection,
          if (!isCollection && size != null) 'size': size,
        },
      };

      // Send the request
      final response = await _apiService.post(
        'cart/update-item',
        data: requestBody,
      );

      if (response['success'] == true) {
        emit(AddToCartSuccess());
      } else {
        emit(AddToCartFailed(
          errMessage: response['message'] ?? 'Failed to decrement quantity',
        ));
      }
    } catch (e) {
      emit(AddToCartFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
