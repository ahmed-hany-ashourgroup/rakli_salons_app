import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/auth/data/models/user_model.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';

part 'confirmation_code_state.dart';

class ConfirmationCodeCubit extends Cubit<ConfirmationCodeState> {
  ConfirmationCodeCubit() : super(ConfirmationCodeInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> confirmCodeSignUp(String code) async {
    try {
      emit(ConfirmationCodeLoading());
      final response = await _apiService.post('auth/verify', data: {
        "email": SalonsUserCubit.user.email,
        "verification_code": code
      });
      emit(ConfirmationCodeSuccess(user: UserModel.fromJson(response)));
      Logger.info(response.toString());
    } catch (e) {
      emit(ConfirmationCodeFailed(errMessage: e.toString()));
    }
  }

  Future<void> confirmCodeDeleteAccount(String code) async {
    try {
      emit(ConfirmationCodeLoading());
      final response = await _apiService.post('auth/verify-delete-account',
          data: {
            "email": SalonsUserCubit.user.email,
            "verification_code": code
          });
      emit(ConfirmationCodeSuccess(user: UserModel.fromJson(response)));
      Logger.info(response.toString());
    } catch (e) {
      emit(ConfirmationCodeFailed(errMessage: e.toString()));
    }
  }

  Future<void> confirmCodeResetPassword(
      {required String code, required String email}) async {
    try {
      emit(ConfirmationCodeLoading());
      final response = await _apiService.post('auth/verify-reset-code',
          data: {"email": email, "reset_code": code});
      emit(ConfirmationCodeSuccess(user: UserModel.fromJson(response)));
      Logger.info(response.toString());
    } catch (e) {
      emit(ConfirmationCodeFailed(errMessage: e.toString()));
    }
  }
}
