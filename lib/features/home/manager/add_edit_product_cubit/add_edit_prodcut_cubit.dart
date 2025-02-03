import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';

import '../../../../core/utils/api_service.dart';

part 'add_edit_prodcut_state.dart';

class AddEditProductCubit extends Cubit<AddEditProductState> {
  AddEditProductCubit() : super(AddEditProductInitial());
  final ApiService _apiService = getIt<ApiService>();

  Future<void> addProduct({
    required FormData data,
  }) async {
    emit(AddEditProductLoading());
    try {
      final response = await _apiService.post(
        'products/store',
        data: data,
      );
      emit(AddEditProductSuccess());
    } catch (e) {
      emit(AddEditProductFailed(errMessage: e.toString()));
    }
  }

  Future<void> updateProduct({
    required int id,
    required FormData data,
  }) async {
    emit(AddEditProductLoading());
    try {
      final response = await _apiService.post(
        'products/update/$id',
        data: data,
      );
      emit(AddEditProductSuccess());
    } catch (e) {
      emit(AddEditProductFailed(errMessage: e.toString()));
    }
  }
}
