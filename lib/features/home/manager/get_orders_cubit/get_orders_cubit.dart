import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/order_model.dart';

part 'get_orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  GetOrdersCubit() : super(GetOrdersInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> getOrders() async {
    emit(GetOrdersLoading());
    try {
      final response = await _apiService.get('orders/business');
      if (response['success'] == true && response['data'] != null) {
        final List<OrderModel> orders = (response['data']['data'] as List)
            .map((order) => OrderModel.fromJson(order))
            .toList();
        emit(GetOrdersSuccess(orders: orders));
      } else {
        emit(GetOrdersFailed(
            errMessage: response['message'] ?? 'Failed to fetch orders'));
      }
    } catch (e) {
      emit(GetOrdersFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
