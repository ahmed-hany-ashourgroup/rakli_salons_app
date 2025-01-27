// business_registration_cubit.dart
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakli_salons_app/core/errors/failure.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/auth/data/models/user_model.dart';
import 'package:rakli_salons_app/features/auth/manager/Business_Registration_Cubit/Business_Registration_state.dart';

class BusinessRegistrationCubit extends Cubit<BusinessRegistrationState> {
  BusinessRegistrationCubit() : super(BusinessRegistrationInitial());

  final ApiService _apiService = getIt<ApiService>();

  Future<Either<Failure, BuisnessUserModel>> register({
    required String businessName,
    required String email,
    required String password,
    required String phone,
    required String address,
    required String role,
    required double latitude,
    required double longitude,
    required String method,
    required File photo,
    File? cover,
    File? tradeLicense,
    File? taxRegistration,
    File? idCard,
  }) async {
    emit(BusinessRegistrationLoading());

    try {
      // Create form data
      final formData = FormData.fromMap({
        'business_name': businessName,
        'email': email,
        'password': password,
        'phone': phone,
        'address': address,
        'role': role,
        'latitude': latitude,
        'longitude': longitude,
        'method': method,
        'photo':
            await MultipartFile.fromFile(photo.path, filename: 'photo.jpg'),
      });

      // Add conditional files based on role
      if (role == 'salon') {
        if (cover != null) {
          formData.files.add(MapEntry(
            'cover',
            await MultipartFile.fromFile(cover.path, filename: 'cover.jpg'),
          ));
        }
        if (tradeLicense != null) {
          formData.files.add(MapEntry(
            'trade_license',
            await MultipartFile.fromFile(tradeLicense.path,
                filename: 'trade_license.jpg'),
          ));
        }
        if (taxRegistration != null) {
          formData.files.add(MapEntry(
            'tax_registration',
            await MultipartFile.fromFile(taxRegistration.path,
                filename: 'tax_registration.jpg'),
          ));
        }
      } else if (role == 'freelancer' && idCard != null) {
        formData.files.add(MapEntry(
          'id_card',
          await MultipartFile.fromFile(idCard.path, filename: 'id_card.jpg'),
        ));
      }

      final response =
          await _apiService.post('business/register', data: formData);

      Logger.info('Registration Response: $response');

      // Check if the request was successful based on the 'success' field
      if (response['success'] == true) {
        // Even if 'data' is null, the registration is successful
        final userModel = BuisnessUserModel.fromJson(response);
        emit(BusinessRegistrationSuccess(user: userModel));
        return Right(userModel);
      } else {
        // Handle cases where 'success' is false
        throw DioException(
          requestOptions: RequestOptions(path: 'business/register'),
          error: response['message'] ?? 'Registration failed',
        );
      }
    } catch (e) {
      final failure = _apiService.handleDioError(e);
      emit(BusinessRegistrationFailed(errMessage: failure.message));
      return Left(failure);
    }
  }
}
