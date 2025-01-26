import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/cart_responce_model.dart';

part 'get_cart_items_state.dart';

class GetCartItemsCubit extends Cubit<GetCartItemsState> {
  GetCartItemsCubit() : super(GetCartItemsInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> getCartItems() async {
    emit(GetCartItemsLoading());
    try {
      final response = await _apiService.get('cart');
      emit(GetCartItemsSuccess(
        cartResponce: CartResponseModel.fromJson(response),
      ));
    } catch (e) {
      Logger.error('Error: $e');
      emit(GetCartItemsFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
