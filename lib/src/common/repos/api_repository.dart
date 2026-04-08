import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/repos/preferences_repository.dart';
import 'package:logger/logger.dart';

class ApiRepository {
  final Logger log = Logger();
  final Dio _dio;
  final PreferencesRepository prefRepo;

  ApiRepository(this._dio, this.prefRepo) {
    _initHeaders();
  }

  void _initHeaders() {
    final String? authToken = prefRepo.getPreference(Constants.store.AUTH_TOKEN);
    log.d("ApiRepository::_initHeaders::Token: $authToken");
    if (authToken != null && authToken.isNotEmpty) {
      _dio.options.headers["Authorization"] = "Bearer $authToken";
    } else {
      _dio.options.headers.remove("Authorization");
    }
  }

  String buildRequest({required Map<String, dynamic> data}) {
    try {
      final Map<String, dynamic> requestJson = {
        "requester": {
          "name": Constants.app.APP_NAME,
          "version": "1.0",
          "timestamp": DateTime.now().toUtc().toIso8601String(),
          "requestedby": prefRepo.getPreference(Constants.store.USER_ID),
        },
      };

      data.forEach((key, value) {
        log.d("ApiRepository::buildRequest::$key - $value");
        requestJson[key] = value;
      });

      log.d("ApiRepository::buildRequest::Final JSON: $requestJson");
      return json.encode(requestJson);
    } catch (error) {
      log.e("ApiRepository::buildRequest::Error: $error");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postRequest({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    try {
      _initHeaders(); // Ensure headers are fresh
      log.d("ApiRepository::postRequest::URL: $url, Data: $data");
      print("🚀 ApiRepository: Token in Header = ${_dio.options.headers['Authorization']}");

      if (Constants.app.USE_MOCK_API) {
        log.d(
          "ApiRepository::postRequest::MOCK MODE ENABLED. Simulating success.",
        );
        await Future.delayed(const Duration(milliseconds: 500));
        return <String, dynamic>{
          "success": true,
          "message": "Mock success",
          "data": <String, dynamic>{
            "authToken": "fake_mock_token_${DateTime.now().millisecondsSinceEpoch}",
            "userId": "999",
            "name": "Mock Dealer",
            "mobile": "1234567890",
          },
        };
      }

      final fullUrl = Constants.api.API_BASE_URL + url;
      final requestBodyString = buildRequest(data: data);

      log.d("ApiRepository::postRequest::Posting to $fullUrl");

      final response = await _dio.post(
        fullUrl,
        data: json.decode(requestBodyString),
      );

      final decoded = _handleResponse(response);
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
      return decoded as Map<String, dynamic>;
    } on DioException catch (dioError) {
      log.e("ApiRepository::postRequest::DioException: ${dioError.message}");
      throw _handleError(dioError);
    }
  }

  Future<dynamic> getRequest(String url) async {
    try {
      _initHeaders(); // Ensure headers are fresh
      if (Constants.app.USE_MOCK_API) {
        log.d(
          "ApiRepository::getRequest::MOCK MODE ENABLED. Simulating success.",
        );
        await Future.delayed(const Duration(milliseconds: 500));
        return <String, dynamic>{
          "success": true,
          "message": "Mocked response",
          "data": <dynamic>[],
        };
      }

      final fullUrl = Constants.api.API_BASE_URL + url;
      final response = await _dio.get(fullUrl);
      return _handleResponse(response);
    } on DioException catch (dioError) {
      log.e("ApiRepository::getRequest::DioException: ${dioError.message}");
      throw _handleError(dioError);
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      final data = response.data;
      if (data is Map) {
        return Map<String, dynamic>.from(data);
      } else if (data is String) {
        try {
          final decoded = jsonDecode(data);
          if (decoded is Map) {
            return Map<String, dynamic>.from(decoded);
          }
          return decoded;
        } catch (error) {
          log.e("ApiRepository::_handleResponse::JSON decode error: $error");
          throw Exception("Failed to decode response JSON: $error");
        }
      } else {
        return data;
      }
    } else {
      throw Exception("HTTP error: ${response.statusCode}");
    }
  }

  Exception _handleError(DioException error) {
    String message = "Network error. Please try again.";

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = "Connection timed out.";
        break;
      case DioExceptionType.badResponse:
        message = "Server error (${error.response?.statusCode}).";
        break;
      case DioExceptionType.cancel:
        message = "Request cancelled.";
        break;
      default:
        message = "Connection failed. Please check your internet.";
        break;
    }

    return Exception(message);
  }
}
