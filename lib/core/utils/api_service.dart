import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rakli_salons_app/core/errors/api_error.dart';
import 'package:rakli_salons_app/core/errors/failure.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';

final String baseUrl = 'http://89.116.110.219/api/';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 18),
          receiveTimeout: const Duration(seconds: 18),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // final token = SalonsUserCubit.user.token;
        final token = "12|MYmh08On7oMASklGZH0fHLhk8kN4sJREKMGsf6eX0c6a7ca7";
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      responseHeader: true,
      responseBody: true,
    ));
  }

  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Logger.info(
          "Request: ${"$baseUrl$endpoint?${queryParameters?.entries.map((e) => '${e.key}=${e.value}').join('&')}"}");
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      Logger.info(response.data.toString());
      return response.data;
    } catch (e) {
      Logger.error('Error: $e');
      throw handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, {dynamic data}) async {
    try {
      dynamic requestData;
      Options options = Options();

      if (data is Map<String, dynamic> && data.containsKey('image')) {
        if (data['image'] is String && File(data['image']).existsSync()) {
          // If image is a local file, convert it to MultipartFile
          requestData = FormData.fromMap({
            ...data,
            'image': await MultipartFile.fromFile(
              data['image'],
              filename: data['image'].split('/').last,
            ),
          });

          // Set content type for FormData
          options.contentType = Headers.multipartFormDataContentType;
        } else {
          // If it's just a URL or no image, send as JSON
          requestData = data;
        }
      } else {
        requestData = data;
      }

      final Response response =
          await _dio.post(endpoint, data: requestData, options: options);

      Logger.info('Response: ${response.data}');

      if (response.data is Map<String, dynamic>) {
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['success'] == true) {
          return responseData;
        } else {
          throw DioException(
            requestOptions: RequestOptions(path: endpoint),
            response: response,
            type: DioExceptionType.badResponse,
            error: responseData['message'] ?? 'Request failed',
          );
        }
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: endpoint),
          error:
              'Invalid response format: expected Map<String, dynamic>, got ${response.data.runtimeType}',
        );
      }
    } catch (e) {
      Logger.error('Error: $e');
      throw handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> put(String endpoint, {dynamic data}) async {
    try {
      FormData formData;

      if (data is Map<String, dynamic> && data.containsKey('image')) {
        // If the image is a File object (new image being uploaded)
        if (data['image'] is String && File(data['image']).existsSync()) {
          formData = FormData.fromMap({
            ...data,
            'image': await MultipartFile.fromFile(
              data['image'],
              filename: data['image'].split('/').last,
            ),
          });
        } else {
          // If it's just a URL string (no change in image)
          formData = FormData.fromMap(data);
        }
      } else {
        formData = FormData.fromMap(data);
      }

      Logger.info('Request Data: $formData');
      final Response response = await _dio.put(endpoint, data: formData);
      Logger.info('Response: ${response.data}');

      if (response.data is Map<String, dynamic>) {
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['success'] == true) {
          return responseData;
        } else {
          throw DioException(
            requestOptions: RequestOptions(path: endpoint),
            response: response,
            type: DioExceptionType.badResponse,
            error: responseData['message'] ?? 'Request failed',
          );
        }
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: endpoint),
          error:
              'Invalid response format: expected Map<String, dynamic>, got ${response.data.runtimeType}',
        );
      }
    } catch (e) {
      Logger.error('Error: $e');
      throw handleDioError(e);
    }
  }

  Future<dynamic> delete(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      Logger.info(response.data);
      return response.data;
    } catch (e) {
      Logger.error('Error: $e');
      throw handleDioError(e);
    }
  }

  ApiError handleApiError(Map<String, dynamic> errorResponse) {
    return ApiError.fromResponse(errorResponse);
  }

  Failure handleDioError(dynamic error) {
    if (error is DioException) {
      Logger.error('DioError: $error');

      if (error.response?.data is Map<String, dynamic>) {
        final responseData = error.response!.data as Map<String, dynamic>;
        // If there's a general message, return it
        if (responseData.containsKey('message')) {
          return Failure(responseData['message'].toString());
        }
        // Handle validation errors
        if (responseData.containsKey('errors')) {
          final errors = responseData['errors'] as Map<String, dynamic>;
          String errorMessage = '';

          // Extract all error messages
          errors.forEach((key, value) {
            if (value is List) {
              errorMessage += value.join('. ');
            } else {
              errorMessage += value.toString();
            }
          });

          // If we have a specific error message, return it
          if (errorMessage.isNotEmpty) {
            return Failure(errorMessage);
          }
        }
      }

      // Handle different DioError types
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Failure(
              'Connection timeout. Please check your internet connection.');
        case DioExceptionType.receiveTimeout:
          return Failure('Server is not responding. Please try again later.');
        case DioExceptionType.sendTimeout:
          return Failure(
              'Unable to send request. Please check your internet connection.');
        case DioExceptionType.badResponse:
          return Failure(
              error.response?.data?['message'] ?? 'Server error occurred.');
        case DioExceptionType.cancel:
          return Failure('Request cancelled.');
        case DioExceptionType.connectionError:
          return Failure('No internet connection. Please check your network.');
        case DioExceptionType.badCertificate:
          return Failure('Security certificate error. Please try again.');
        case DioExceptionType.unknown:
          return Failure('An unexpected error occurred. Please try again.');
      }
    }

    return Failure(error.toString());
  }
}
