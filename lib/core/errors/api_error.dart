class ApiError {
  final String message;
  final Map<String, List<String>>? validationErrors;
  final int? statusCode;

  ApiError({
    required this.message,
    this.validationErrors,
    this.statusCode,
  });

  factory ApiError.fromResponse(Map<String, dynamic> response) {
    // Extract validation errors if they exist
    Map<String, List<String>>? validationErrors;
    if (response['errors'] != null && response['errors'] is Map) {
      validationErrors = {};
      (response['errors'] as Map).forEach((key, value) {
        if (value is List) {
          validationErrors?[key.toString()] =
              value.map((e) => e.toString()).toList();
        } else {
          validationErrors?[key.toString()] = [value.toString()];
        }
      });
    }

    return ApiError(
      message:
          response['message']?.toString() ?? 'An unexpected error occurred',
      validationErrors: validationErrors,
      statusCode: response['status_code'] as int?,
    );
  }

  String get displayMessage {
    if (validationErrors != null && validationErrors!.isNotEmpty) {
      return validationErrors!.values.expand((element) => element).join('\n');
    }
    return message;
  }
}
