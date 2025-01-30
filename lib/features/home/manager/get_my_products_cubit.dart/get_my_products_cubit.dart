import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';

part 'get_my_products_state.dart';

class GetMyProductsCubit extends Cubit<GetMyProductsState> {
  GetMyProductsCubit() : super(GetMyProductsInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> getMyProducts() async {
    emit(GetMyProductsLoading());
    try {
      final response = await _apiService.get('products/all');
      final List<ProductModel> products =
          (response['data']['unassigned_products']['data'] as List)
              .map((product) => ProductModel.fromJson(product))
              .toList();
      emit(GetMyProductsSuccess(products: products));
    } catch (e) {
      emit(GetMyProductsFailed(errMessage: e.toString()));
    }
  }
}
