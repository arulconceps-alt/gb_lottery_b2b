import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/models/login_model.dart';
import 'package:gb_lottery_b2b/src/common/repos/api_repository.dart';
import 'package:gb_lottery_b2b/src/common/repos/preferences_repository.dart';

/// [LoginRepository] manages authentication-related operations.
/// It interacts with [ApiRepository] for network calls and [PreferencesRepository] for session storage.
class LoginRepository {
  final ApiRepository _apiRepository;
  final PreferencesRepository _preferencesRepository;

  LoginRepository(this._apiRepository, this._preferencesRepository);

  /// Requests an OTP for a given mobile number.
  /// Throws [Exception] if mobile number is invalid or request fails.
  Future<void> requestOtp({required String mobile}) async {
    try {
      if (!_isValidMobile(mobile)) {
        throw Exception('Please enter a valid 10-digit mobile number');
      }

      await _apiRepository.postRawRequest(
        url: Constants.api.login,
        data: {"phone": mobile},
      );
    } catch (e) {
      // TODO: Log error to a monitoring service like Sentry
      rethrow;
    }
  }

  /// Verifies OTP and performs login.
  /// Saves [authToken] and [userId] to local storage upon successful verification.
  Future<LoginModel> loginWithOtp({
    required String mobile,
    required String otp,
  }) async {
    try {
      if (mobile.isEmpty || otp.isEmpty) {
        throw Exception('Mobile and OTP are required');
      }

      final responseData = await _apiRepository.postRawRequest(
        url: Constants.api.verifyOtp,
        data: {"phone": mobile, "otp": otp},
      );

      return _processLoginResponse(responseData);
    } catch (e) {
      rethrow;
    }
  }

  /// Performs login using mobile and password.
  Future<LoginModel> loginWithPassword({
    required String mobile,
    required String password,
  }) async {
    try {
      if (mobile.isEmpty || password.isEmpty) {
        throw Exception('Mobile and password are required');
      }

      final responseData = await _apiRepository.postRawRequest(
        url: Constants.api.login,
        data: {'phone': mobile, 'password': password},
      );

      return _processLoginResponse(responseData);
    } catch (e) {
      rethrow;
    }
  }

  /// Clears local session data and optionally notifies the backend.
  Future<void> logout() async {
    try {
      // TODO: If using FCM, unregister the device token before clearing preferences
      
      await _preferencesRepository.removePreference(Constants.store.AUTH_TOKEN);
      await _preferencesRepository.removePreference(Constants.store.USER_ID);

      if (!Constants.app.USE_MOCK_API) {
        // TODO: Implement server-side logout to invalidate the token
        // await _apiRepository.postRequest(url: Constants.api.logout, data: {});
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Internal helper to process successful login responses and persist session data.
  Future<LoginModel> _processLoginResponse(Map<String, dynamic> responseData) async {
    if (responseData['success'] == true) {
      final userData = responseData['data'] != null
          ? Map<String, dynamic>.from(responseData['data'])
          : <String, dynamic>{};

      final user = LoginModel.fromJson(userData);

      if (user.authToken.isNotEmpty) {
        await _preferencesRepository.setPreference(
          Constants.store.AUTH_TOKEN,
          user.authToken,
        );
      }
      if (user.userId.isNotEmpty) {
        await _preferencesRepository.setPreference(
          Constants.store.USER_ID,
          user.userId,
        );
      }

      return user;
    } else {
      throw Exception(responseData['message'] ?? 'Authentication failed');
    }
  }

  /// Validates if the string is a standard 10-digit mobile number.
  bool _isValidMobile(String mobile) {
    // Simple 10-digit validation
    return mobile.length == 10 && RegExp(r'^[0-9]+$').hasMatch(mobile);
  }
}
