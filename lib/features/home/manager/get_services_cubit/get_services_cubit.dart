// get_services_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/features/home/data/models/models/service_model.dart';

part 'get_services_state.dart';

class GetServicesCubit extends Cubit<GetServicesState> {
  GetServicesCubit() : super(GetServicesInitial());

  final ApiService _apiService = ApiService();

  Future<void> fetchServices() async {
    emit(GetServicesLoading());
    try {
      final response = await _apiService.get('business-services');

      // Check if response is Map
      if (response is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      // Check for success status
      if (response['success'] != true) {
        throw Exception(response['message'] ?? 'Failed to fetch services');
      }

      // Access the nested data structure correctly
      final responseData = response['data'] as Map<String, dynamic>;
      final servicesData = responseData['data'] as List<dynamic>;

      // Convert the services data
      final services = servicesData
          .map((json) => ServiceModel.fromJson(json as Map<String, dynamic>))
          .toList();

      emit(GetServicesSuccess(services: services));
    } catch (e) {
      emit(GetServicesFailed(errMessage: e.toString()));
    }
  }
}
