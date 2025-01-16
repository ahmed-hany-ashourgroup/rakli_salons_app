import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(SignUpLaoding());
    try {
      // Log the request payload
      Logger.info(
          'Sending registration request with data: {name: $name, email: $email, phone: $phone, method: email}');

      final response = await _apiService.post('auth/register', data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'method': 'email',
      });

      Logger.info('Sign Up Response: $response');
      emit(SignUpSuccess());
    } catch (e) {
      String errorMessage = e.toString();
      if (e is DioException) {
        // Extract the specific error message from the response if available
        final responseData = e.response?.data;
        if (responseData is Map) {
          errorMessage = responseData['message'] ?? errorMessage;
          // Log validation errors if present
          if (responseData['errors'] != null) {
            Logger.error('Validation errors: ${responseData['errors']}');
          }
        }
      }
      emit(SignUpFailed(errMessage: errorMessage));
    }
  }
}
