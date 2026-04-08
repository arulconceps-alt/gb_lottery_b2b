import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/models/login_model.dart';
import 'package:gb_lottery_b2b/src/common/repos/api_repository.dart';
import 'package:gb_lottery_b2b/src/common/repos/preferences_repository.dart';

class LoginRepository {
  final ApiRepository _apiRepository;
  final PreferencesRepository _preferencesRepository;

  LoginRepository(this._apiRepository, this._preferencesRepository);

  Future<void> requestOtp({required String mobile}) async {
    try {
      if (mobile.length != 10) {
        throw Exception('Please enter a valid 10-digit mobile number');
      }
      
      await _apiRepository.postRequest(
        url: Constants.api.resendOtp,
        data: {'mobile': mobile},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginModel> loginWithOtp({
    required String mobile,
    required String otp,
  }) async {
    try {
      if (mobile.isEmpty || otp.isEmpty) {
        throw Exception('Mobile and OTP are required');
      }

      final response = await _apiRepository.postRequest(
        url: Constants.api.verifyOtp,
        data: {
          'mobile': mobile,
          'otp': otp,
        },
      );

      if (response['success'] == true) {
        final userData = response['data'] != null
            ? Map<String, dynamic>.from(response['data'])
            : <String, dynamic>{};
        
        final user = LoginModel.fromJson(userData);
        
        // Save to Preferences
        await _preferencesRepository.setPreference(Constants.store.AUTH_TOKEN, user.authToken);
        await _preferencesRepository.setPreference(Constants.store.USER_ID, user.userId);
        
        return user;
      } else {
        throw Exception(response['message'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginModel> loginWithPassword({
    required String mobile,
    required String password,
  }) async {
    try {
      if (mobile.isEmpty || password.isEmpty) {
        throw Exception('Mobile and password are required');
      }

      final response = await _apiRepository.postRequest(
        url: Constants.api.login,
        data: {
          'mobile': mobile,
          'password': password,
        },
      );

      if (response['success'] == true) {
        final userData = response['data'] != null
            ? Map<String, dynamic>.from(response['data'])
            : <String, dynamic>{};
            
        final user = LoginModel.fromJson(userData);

        // Save to Preferences
        await _preferencesRepository.setPreference(Constants.store.AUTH_TOKEN, user.authToken);
        await _preferencesRepository.setPreference(Constants.store.USER_ID, user.userId);

        return user;
      } else {
        throw Exception(response['message'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      // Clear Preferences
      await _preferencesRepository.removePreference(Constants.store.AUTH_TOKEN);
      await _preferencesRepository.removePreference(Constants.store.USER_ID);
      
      // Optionally call a logout API if not in MOCK mode
      if (!Constants.app.USE_MOCK_API) {
        // await _apiRepository.postRequest(url: Constants.api.logout, data: {});
      }
    } catch (e) {
      rethrow;
    }
  }
}
