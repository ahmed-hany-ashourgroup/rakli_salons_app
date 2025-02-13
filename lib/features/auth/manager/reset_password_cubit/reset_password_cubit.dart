import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  final _apiService = getIt<ApiService>();

  Future<void> requestResetPassword(String email) async {
    emit(ResetPasswordLoading());
    try {
      await _apiService.post('business/request-password-reset', data: {
        'email': email,
      });
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailed(errMessage: e.toString()));
    }
  }

  Future<void> verifyPasswordRest(
      {required String email, required String resetCode}) async {
    emit(ResetPasswordLoading());
    try {
      await _apiService.post('business/verify-reset-code', data: {
        'email': email,
        'reset_code': resetCode,
      });
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailed(errMessage: e.toString()));
    }
  }

  Future<void> resetPassword(
      {required String newPassword,
      required String email,
      required String resetCode}) async {
    try {
      emit(ResetPasswordLoading());
      final response = await _apiService.post('business/reset-password', data: {
        "email": email,
        'password': newPassword,
        'reset_code': resetCode
      });
      emit(ResetPasswordSuccess());
      Logger.info(response.toString());
    } catch (e) {
      emit(ResetPasswordFailed(errMessage: e.toString()));
    }
  }
}
