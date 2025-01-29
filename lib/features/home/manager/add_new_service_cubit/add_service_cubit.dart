// add_service_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';

part 'add_service_state.dart';

class AddServiceCubit extends Cubit<AddServiceState> {
  AddServiceCubit() : super(AddServiceInitial());

  final ApiService _apiService = ApiService();

  Future<void> addService({
    required String title,
    required String description,
    required double price,
    required String gender,
    double? promotions,
  }) async {
    emit(AddServiceLoading());
    Logger.info(SalonsUserCubit.user.id.toString());
    try {
      final response = await _apiService.post(
        'business-services/add',
        data: {
          'business_id': SalonsUserCubit.user.id,
          'title': title,
          'description': description,
          'price': price,
          'gender': gender,
          if (promotions != null) 'promotions': promotions.toString(),
        },
      );

      if (response['success'] == true) {
        emit(AddServiceSuccess(
          message: response['message'] ?? 'Service added successfully',
        ));
      } else {
        throw Exception(response['message'] ?? 'Failed to add service');
      }
    } catch (e) {
      emit(AddServiceFailure(error: e.toString()));
    }
  }

  Future<void> updateService({
    required int serviceId,
    required String title,
    required String description,
    required double price,
    required String gender,
    double? promotions,
  }) async {
    emit(AddServiceLoading());

    try {
      Logger.info(SalonsUserCubit.user.id.toString());
      final response = await _apiService.put(
        'business-services/edit/$serviceId',
        data: {
          "business_id": SalonsUserCubit.user.id,
          'title': title,
          'description': description,
          'price': price.toString(),
          'gender': gender,
          if (promotions != null) 'promotions': promotions.toString(),
        },
      );

      if (response is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      if (response['success'] == true) {
        emit(AddServiceSuccess(
          message: response['message'] ?? 'Service updated successfully',
        ));
      } else {
        throw Exception(response['message'] ?? 'Failed to update service');
      }
    } catch (e) {
      emit(AddServiceFailure(error: e.toString()));
    }
  }
}
