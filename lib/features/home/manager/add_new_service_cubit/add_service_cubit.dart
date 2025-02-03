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

  /// Validates service input parameters
  void _validateServiceInput({
    required String title,
    required String description,
    required double price,
    required String gender,
  }) {
    if (title.isEmpty) throw Exception('Title cannot be empty');
    if (description.isEmpty) throw Exception('Description cannot be empty');
    if (price <= 0) throw Exception('Price must be greater than 0');
    if (!['male', 'female', 'unisex'].contains(gender.toLowerCase())) {
      throw Exception('Invalid gender value');
    }
  }

  /// Prepares service data for API request
  Map<String, dynamic> _prepareServiceData({
    required String title,
    required String description,
    required double price,
    required String gender,
    double? promotions,
  }) {
    return {
      'business_id': SalonsUserCubit.user.id,
      'title': title,
      'description': description,
      'price': price.toString(),
      'gender': gender,
      if (promotions != null) 'promotions': promotions.toString(),
    };
  }

  /// Handles API response and emits appropriate state
  void _handleApiResponse(
      Map<String, dynamic> response, String successMessage) {
    if (response['success'] == true) {
      emit(AddServiceSuccess(
        message: response['message'] ?? successMessage,
      ));
    } else {
      throw Exception(response['message'] ?? 'Operation failed');
    }
  }

  Future<void> addService({
    required String title,
    required String description,
    required double price,
    required String gender,
    double? promotions,
  }) async {
    emit(AddServiceLoading());

    try {
      _validateServiceInput(
        title: title,
        description: description,
        price: price,
        gender: gender,
      );

      Logger.info('Adding service for user: ${SalonsUserCubit.user.id}');
      final response = await _apiService.post(
        'business-services/add',
        data: _prepareServiceData(
          title: title,
          description: description,
          price: price,
          gender: gender,
          promotions: promotions,
        ),
      );

      _handleApiResponse(response, 'Service added successfully');
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
      _validateServiceInput(
        title: title,
        description: description,
        price: price,
        gender: gender,
      );

      Logger.info(
          'Updating service $serviceId for user: ${SalonsUserCubit.user.id}');
      final response = await _apiService.put(
        'business-services/edit/$serviceId',
        data: _prepareServiceData(
          title: title,
          description: description,
          price: price,
          gender: gender,
          promotions: promotions,
        ),
      );

      _handleApiResponse(response, 'Service updated successfully');
    } catch (e) {
      emit(AddServiceFailure(error: e.toString()));
    }
  }
}
