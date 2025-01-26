import 'package:dio/dio.dart';
import 'package:rakli_salons_app/core/errors/failure.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';

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
        // Add Authorization header if the token is available
        final token = SalonsUserCubit.user.token;
        if (token != null && token.isNotEmpty) {
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
          "allll  ${"$baseUrl$endpoint?${queryParameters?.entries.map((e) => '${e.key}=${e.value}').join('&')}"}");
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
      Logger.info('Request Data: $data'); // Log request data
      final Response response = await _dio.post(endpoint, data: data);
      Logger.info('Response: ${response.data}');

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: endpoint),
          error:
              'Invalid response format: expected Map<String, dynamic>, got ${response.data.runtimeType}',
        );
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        Logger.error('Error Status Code: ${e.response?.statusCode}');
        Logger.error('Error Response Data: ${e.response?.data}');

        // Handle validation errors (status code 422)
        if (e.response?.statusCode == 422) {
          final errorData = e.response?.data;
          if (errorData is Map && errorData['errors'] != null) {
            // Extract validation error messages
            final errors = errorData['errors'] as Map<String, dynamic>;
            final errorMessages = errors.values
                .map((errorList) => errorList.join(', '))
                .join(', ');
            throw Failure('Validation error: $errorMessages');
          } else {
            throw Failure(errorData['message'] ?? 'Validation error occurred');
          }
        }

        // Handle other server errors
        throw Failure(e.response?.data['message'] ?? 'An error occurred');
      }
      Logger.error('Error: $e');
      throw handleDioError(e);
    }
  }

  Future<dynamic> put(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      Logger.info(response.data.toString());
      return response.data;
    } catch (e) {
      Logger.error('Error: ${e.toString()}');
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

  Failure handleDioError(dynamic error) {
    if (error is DioException) {
      Logger.error('Error: $error');
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Failure(
              'Connection timeout. Please check your internet connection.');
        case DioExceptionType.receiveTimeout:
          return Failure('Server took too long to respond. Please try again.');
        case DioExceptionType.sendTimeout:
          return Failure(
              'Request timed out. Please check your internet connection.');
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode ?? 500;
          if (statusCode == 401) {
            return Failure('Unauthorized. Please log in again.');
          } else if (statusCode == 404) {
            return Failure('Resource not found.');
          } else if (statusCode == 500) {
            return Failure('Server error. Please try again later.');
          } else {
            return Failure('An error occurred. Status code: $statusCode');
          }
        case DioExceptionType.cancel:
          return Failure('Request cancelled.');
        case DioExceptionType.unknown:
          return Failure('An unexpected error occurred. Please try again.');
        case DioExceptionType.badCertificate:
          return Failure('Invalid certificate. Please contact support.');
        case DioExceptionType.connectionError:
          return Failure(
              'Connection error. Please check your internet connection.');
      }
    }
    return Failure('An unknown error occurred. Please try again.');
  }
}
