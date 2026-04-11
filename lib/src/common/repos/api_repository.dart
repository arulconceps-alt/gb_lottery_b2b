import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/repos/preferences_repository.dart';
import 'package:logger/logger.dart';

/// [ApiRepository] acts as the central network layer for the application.
/// It handles header initialization, request wrapping, and error handling.
class ApiRepository {
  final Logger _log = Logger();
  final Dio _dio;
  final PreferencesRepository _prefRepo;

  ApiRepository(this._dio, this._prefRepo) {
    _initHeaders();
  }

  /// Initializes standard headers for API requests.
  /// Automatically includes the Bearer token if available in [PreferencesRepository].
  void _initHeaders() {
    final String? authToken = _prefRepo.getPreference(Constants.store.AUTH_TOKEN);
    _log.d("ApiRepository::_initHeaders::Token: $authToken");
    
    if (authToken != null && authToken.isNotEmpty) {
      _dio.options.headers["Authorization"] = "Bearer $authToken";
    } else {
      _dio.options.headers.remove("Authorization");
    }
    
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.headers["Accept"] = "*/*";
  }

  /// Constructs the standard request wrapper expected by the legacy backend.
  /// Returns a [Map] to avoid unnecessary encoding/decoding cycles.
  Map<String, dynamic> buildWrappedRequest({
    required Map<String, dynamic> data,
    String? requestName,
  }) {
    return {
      "requester": {
        "name": Constants.app.APP_NAME,
        "version": "1.0",
        "timestamp": DateTime.now().toUtc().toIso8601String(),
        "requestedby": _prefRepo.getPreference(Constants.store.USER_ID) ?? "",
      },
      Constants.api.REQUEST_NAME: requestName ?? "",
      Constants.api.DATA: data,
    };
  }

  /// Generic POST request method.
  /// [isRaw] determines if the data should be wrapped in the standard requester format.
  Future<Map<String, dynamic>> postRequest({
    required String url,
    required Map<String, dynamic> data,
    String? requestName,
    bool isRaw = false,
    String? baseUrl,
  }) async {
    try {
      _initHeaders(); // Ensure headers are fresh
      
      if (Constants.app.USE_MOCK_API) {
        return _simulateMockResponse("postRequest", url);
      }

      final fullUrl = (baseUrl ?? Constants.api.API_BASE_URL) + url;
      final requestBody = isRaw ? data : buildWrappedRequest(data: data, requestName: requestName);

      _log.d("ApiRepository::postRequest::Posting to $fullUrl with body: $requestBody");

      final response = await _dio.post(
        fullUrl,
        data: requestBody,
      );

      final decoded = _handleResponse(response);
      return Map<String, dynamic>.from(decoded);
    } on DioException catch (dioError) {
      _log.e("ApiRepository::postRequest::DioException: ${dioError.message ?? dioError.toString()}");
      throw _handleError(dioError);
    }
  }

  /// Generic GET request method.
  Future<dynamic> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
    String? baseUrl,
  }) async {
    try {
      _initHeaders();

      if (Constants.app.USE_MOCK_API) {
        return _simulateMockResponse("getRequest", url);
      }

      final String fullUrl = (baseUrl ?? Constants.api.API_BASE_URL) + url;

      final response = await _dio.get(
        fullUrl,
        queryParameters: queryParameters,
      );
      
      return _handleResponse(response);
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 401) {
        _log.w("ApiRepository::getRequest::Unauthorized access blocked");
      } else {
        _log.e("ApiRepository::getRequest::DioException: ${dioError.message ?? dioError.toString()}");
      }
      throw _handleError(dioError);
    }
  }

  /// Generic PUT request method.
  Future<Map<String, dynamic>> putRequest({
    required String url,
    required Map<String, dynamic> data,
    String? requestName,
    bool isRaw = true, // Default to true for updates as they are often raw
    String? baseUrl,
  }) async {
    try {
      _initHeaders();
      final fullUrl = (baseUrl ?? Constants.api.API_BASE_URL) + url;
      final requestBody = isRaw ? data : buildWrappedRequest(data: data, requestName: requestName);
      
      _log.d("ApiRepository::putRequest::Putting to $fullUrl");

      final response = await _dio.put(
        fullUrl,
        data: requestBody,
      );

      final decoded = _handleResponse(response);
      return Map<String, dynamic>.from(decoded);
    } on DioException catch (dioError) {
      _log.e("ApiRepository::putRequest::DioException: ${dioError.message ?? dioError.toString()}");
      throw _handleError(dioError);
    }
  }

  /// Generic PATCH request method.
  Future<Map<String, dynamic>> patchRequest({
    required String url,
    required Map<String, dynamic> data,
    String? requestName,
    bool isRaw = true,
    String? baseUrl,
  }) async {
    try {
      _initHeaders();
      final fullUrl = (baseUrl ?? Constants.api.API_BASE_URL) + url;
      final requestBody = isRaw ? data : buildWrappedRequest(data: data, requestName: requestName);
      
      _log.d("ApiRepository::patchRequest::Patching to $fullUrl");

      final response = await _dio.patch(
        fullUrl,
        data: requestBody,
      );

      final decoded = _handleResponse(response);
      return Map<String, dynamic>.from(decoded);
    } on DioException catch (dioError) {
      _log.e("ApiRepository::patchRequest::DioException: ${dioError.message}");
      throw _handleError(dioError);
    }
  }

  /// Generic DELETE request method.
  Future<Map<String, dynamic>> deleteRequest({
    required String url,
    Map<String, dynamic>? data,
    String? baseUrl,
  }) async {
    try {
      _initHeaders();
      final fullUrl = (baseUrl ?? Constants.api.API_BASE_URL) + url;
      _log.d("ApiRepository::deleteRequest::Deleting at $fullUrl");

      final response = await _dio.delete(
        fullUrl,
        data: data,
      );

      final decoded = _handleResponse(response);
      return Map<String, dynamic>.from(decoded);
    } on DioException catch (dioError) {
      _log.e("ApiRepository::deleteRequest::DioException: ${dioError.message}");
      throw _handleError(dioError);
    }
  }

  /// Convenience method for POSTing raw JSON payloads.
  Future<Map<String, dynamic>> postRawRequest({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return postRequest(url: url, data: data, isRaw: true);
  }

  /// Convenience method for PUTting raw JSON payloads.
  Future<Map<String, dynamic>> putRawRequest({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return putRequest(url: url, data: data, isRaw: true);
  }

  /// Convenience method for PATCHing raw JSON payloads.
  Future<Map<String, dynamic>> patchRawRequest({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return patchRequest(url: url, data: data, isRaw: true);
  }

  /// Handles the transformation of [Response] into usable data.
  dynamic _handleResponse(Response response) {
    _log.d("ApiRepository::_handleResponse::Status: ${response.statusCode}, Data: ${response.data}");
    
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final data = response.data;
      if (data is Map) {
        return Map<String, dynamic>.from(data);
      } else if (data is String) {
        try {
          final decoded = jsonDecode(data);
          return decoded is Map ? Map<String, dynamic>.from(decoded) : decoded;
        } catch (error) {
          _log.e("ApiRepository::_handleResponse::JSON decode error: $error");
          throw Exception("Failed to decode response JSON: $error");
        }
      }
      return data;
    } else {
      if (response.statusCode == 401) {
        _log.w("ApiRepository::_handleResponse::Unauthorized (401). Clearing token on next frame.");
        Future.microtask(() => _prefRepo.removePreference(Constants.store.AUTH_TOKEN));
        throw Exception("Session expired. Please log in again.");
      }
      throw Exception("HTTP error: ${response.statusCode}");
    }
  }

  /// Centralized error handling for [DioException].
  Exception _handleError(DioException error) {
    String message = "Network error. Please try again.";

    if (error.response?.data != null && error.response?.data is Map) {
      message = error.response?.data['message'] ?? message;
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = "Connection timed out.";
        break;
      case DioExceptionType.badResponse:
        final code = error.response?.statusCode;
        if (code == 401) {
          // Only force a global logout if the primary authentication API rejects the token
          final uri = error.requestOptions.uri.toString();
          if (uri.startsWith(Constants.api.API_BASE_URL)) {
             _log.w("ApiRepository::_handleError::Unauthorized (401) on Main API. Clearing token.");
             Future.microtask(() => _prefRepo.removePreference(Constants.store.AUTH_TOKEN));
             message = "Session expired. Please log in again.";
          } else {
             _log.w("ApiRepository::_handleError::Unauthorized (401) on Secondary API ($uri). Skipping global logout.");
             message = "Unauthorized (Secondary Service)";
          }
        } else {
          message = message.contains("Network error") ? "Server error ($code)." : message;
        }
        break;
      default:
        break;
    }

    return Exception(message);
  }

  /// Helper to simulate responses when in Mock mode.
  Future<Map<String, dynamic>> _simulateMockResponse(String method, String url) async {
    _log.d("ApiRepository::$method::MOCK MODE ENABLED for $url");
    await Future.delayed(const Duration(milliseconds: 500));
    return <String, dynamic>{
      "success": true,
      "message": "Mock success",
      "data": <String, dynamic>{
        "authToken": "fake_mock_token_${DateTime.now().millisecondsSinceEpoch}",
        "userId": "999",
      },
    };
  }
}
