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
        final token = SalonsUserCubit
            .user.token; // Replace with your actual token retrieval logic
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
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      Logger.info(response.data);
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

        // If there's validation errors, they're usually in response.data
        if (e.response?.statusCode == 422) {
          final errorData = e.response?.data;
          throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            error: errorData is Map
                ? errorData['message'] ?? errorData.toString()
                : errorData.toString(),
          );
        }
      }
      Logger.error('Error: $e');
      throw handleDioError(e);
    }
  }

  Future<dynamic> put(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      Logger.info(response.data);
      return response.data;
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

  DioException handleDioError(dynamic error) {
    if (error is DioException) {
      Logger.error('Error: $error');
      return error;
    }
    Logger.error('Error: $error');

    return DioException(
      requestOptions: RequestOptions(path: ''),
      error: error.toString(),
    );
  }

  Failure handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Failure('Connection timeout');
        case DioExceptionType.receiveTimeout:
          return Failure('Receive timeout');
        case DioExceptionType.sendTimeout:
          return Failure('Send timeout');
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode ?? 500;
          return Failure(
            'Error $statusCode: ${error.response?.data['message'] ?? 'Unknown error'}',
          );
        case DioExceptionType.cancel:
          return Failure('Request cancelled');
        case DioExceptionType.unknown:
          return Failure('Unexpected error: ${error.message}');
        case DioExceptionType.badCertificate:
          return Failure('Bad certificate: ${error.message}');
        case DioExceptionType.connectionError:
          return Failure('Connection error: ${error.message}');
      }
    }
    return Failure('Unknown error occurred');
  }
}
