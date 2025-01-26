import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit() : super(GetProductsInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> getAllProducts() async {
    emit(GetProductsLoading());
    try {
      final response = await _apiService.get('products');

      // Extract the 'collections' and 'unassigned_products' fields from the response
      final List<dynamic> collectionsData = response['collections']['data'];
      final List<dynamic> unassignedProductsData =
          response['unassigned_products']['data'];

      // Convert collections to ProductModel with isCollection = true
      final List<ProductModel> collections = collectionsData
          .map((json) => ProductModel.fromJson(json, isCollection: true))
          .toList();

      // Convert unassigned products to ProductModel with isCollection = false
      final List<ProductModel> unassignedProducts = unassignedProductsData
          .map((json) => ProductModel.fromJson(json, isCollection: false))
          .toList();

      // Combine collections and unassigned products into a single list
      final List<ProductModel> allProducts = [];
      allProducts.addAll(collections);
      allProducts.addAll(unassignedProducts);

      emit(GetProductsSuccess(products: allProducts));
    } catch (e) {
      emit(GetProductsFailed(errMessage: e.toString()));
    }
  }

  Future<void> getTopRatedProducts() async {
    emit(GetProductsLoading());
    try {
      final response = await _apiService.get('products/top-ten-rating');

      // Extract the 'data' field from the response
      final List<dynamic> data = response['data'];

      // Convert each item in 'data' to a ProductModel object
      final List<ProductModel> products =
          data.map((json) => ProductModel.fromJson(json)).toList();

      emit(GetProductsSuccess(products: products));
    } catch (e) {
      emit(GetProductsFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
