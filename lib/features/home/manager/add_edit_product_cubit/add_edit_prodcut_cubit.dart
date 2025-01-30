import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';

import '../../../../core/utils/api_service.dart';

part 'add_edit_prodcut_state.dart';

class AddEditProductCubit extends Cubit<AddEditProductState> {
  AddEditProductCubit() : super(AddEditProductInitial());
  final ApiService _apiService = getIt<ApiService>();

  Future<void> addProduct({
    required String title,
    required String description,
    required String details, // Updated parameter
    required String image,
    double? discount,
    required String productType,
    required String stockStatus,
  }) async {
    emit(AddEditProductLoading());
    try {
      final response = await _apiService.post(
        'products/store',
        data: {
          'title': title,
          'description': description,
          'details':
              details, // This will be sent as [{"size":50, "price":20.5}, ...]
          'image': image,
          'discount': discount,
          'product_type': productType,
          'stock_status': stockStatus,
        },
      );
      emit(AddEditProductSuccess());
    } catch (e) {
      emit(AddEditProductFailed(errMessage: e.toString()));
    }
  }

  Future<void> updateProduct({
    required int id,
    required String title,
    required String description,
    required String details, // Updated parameter
    required String image,
    double? discount,
    required String productType,
    required String stockStatus,
  }) async {
    emit(AddEditProductLoading());
    try {
      final response = await _apiService.put(
        'products/update/$id',
        data: {
          'title': title,
          'description': description,
          'details':
              details, // This will be sent as [{"size":50, "price":20.5}, ...]
          'image': image,
          'discount': discount,
          'product_type': productType,
          'stock_status': stockStatus,
          '_method': 'PUT',
        },
      );
      emit(AddEditProductSuccess());
    } catch (e) {
      emit(AddEditProductFailed(errMessage: e.toString()));
    }
  }
}
