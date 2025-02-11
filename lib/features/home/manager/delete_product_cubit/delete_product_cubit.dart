import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit() : super(DeleteProductInitial());
  final ApiService _apiService = getIt<ApiService>();

  Future<void> deleteProduct(int id) async {
    emit(DeleteProductLoading());
    try {
      await _apiService.delete('products/delete/$id');
      emit(DeleteProductSuccess());
    } catch (e) {
      emit(DeleteProductFailed(errMessage: e.toString()));
    }
  }
}
