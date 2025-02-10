import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/auth/data/models/user_model.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> updateProfile({
    required String email,
    required String name,
    required String phone,
    required String buissniesId,
  }) async {
    emit(UpdateProfileLoading());
    try {
      final response =
          await _apiService.post('business/update-profile/$buissniesId', data: {
        'email': email,
        'business_name': name,
        'phone': phone,
        '_method': 'PUT',
      });

      if (response['success'] == true && response['data'] != null) {
        final updatedUser = BuisnessUserModel()
          ..id = response['data']['id']
          ..name = response['data']['business_name']
          ..email = response['data']['email']
          ..phone = response['data']['phone']
          ..address = response['data']['address']
          ..role = response['data']['role']
          ..latitude =
              double.tryParse(response['data']['latitude']?.toString() ?? '')
          ..longitude =
              double.tryParse(response['data']['longitude']?.toString() ?? '')
          ..createdAt = response['data']['created_at'] != null
              ? DateTime.parse(response['data']['created_at'])
              : null
          ..updatedAt = response['data']['updated_at'] != null
              ? DateTime.parse(response['data']['updated_at'])
              : null;

        SalonsUserCubit.user = updatedUser;

        emit(UpdateProfileSuccess(user: updatedUser));
      } else {
        emit(UpdateProfileFailed(
            errMessage: response['message'] ?? 'Failed to update profile'));
      }
    } catch (e) {
      emit(UpdateProfileFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
