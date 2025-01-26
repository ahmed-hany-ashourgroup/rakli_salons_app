import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/check_out_model.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> placeOrder({required String paymentMethod}) async {
    emit(CheckOutLoading()); // Emit loading state
    try {
      // Prepare the request body
      final Map<String, dynamic> requestBody = {
        'payment_type': paymentMethod,
      };

      // Call the API to place the order
      final response = await _apiService.post(
        'cart/checkout', // Replace with your actual endpoint
        data: requestBody,
      );

      // Parse the response
      final CheckoutDataModel checkOutModel =
          CheckoutDataModel.fromJson(response);

      // Emit success state with the parsed response
      emit(CheckOutSuccess(checkOutModel: checkOutModel));
    } catch (e) {
      // Emit failed state with the error message
      emit(CheckOutFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
