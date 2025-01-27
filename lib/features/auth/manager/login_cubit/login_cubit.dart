import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/auth/data/models/user_model.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';

import '../../../../core/errors/failure.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final ApiService _apiService = getIt<ApiService>();

  Future<Either<Failure, BuisnessUserModel>> login(
      String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await _apiService
          .post('auth/login', data: {'email': email, 'password': password});

      // Log the response for debugging
      Logger.info('Login Response: $response');

      if (response['data'] == null) {
        throw DioException(
          requestOptions: RequestOptions(path: 'auth/login'),
          error: 'Invalid response format: missing data field',
        );
      }

      final userModel = BuisnessUserModel.fromJson(response);
      SalonsUserCubit.user = userModel;
      Logger.info('UserModel: $userModel');
      emit(LoginSuccess(user: userModel));
      return Right(userModel);
    } catch (e) {
      final failure = _apiService.handleDioError(e);
      emit(LoginFailed(errMessage: failure.message));
      return Left(failure);
    }
  }
}
