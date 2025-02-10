import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';

part 'delete_service_state.dart';

class DeleteServiceCubit extends Cubit<DeleteServiceState> {
  DeleteServiceCubit() : super(DeleteServiceInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> deleteService(String serviceId) async {
    emit(DeleteServiceLoading());
    try {
      final response = await _apiService.delete(
        'business-services/delete/$serviceId',
      );

      if (response['success'] == true) {
        emit(DeleteServiceSuccess());
      } else {
        emit(DeleteServiceFailed(
          errMessage: response['message'] ?? 'Failed to delete service',
        ));
      }
    } catch (e) {
      emit(DeleteServiceFailed(
        errMessage: _apiService.handleDioError(e.toString()).message,
      ));
    }
  }
}
