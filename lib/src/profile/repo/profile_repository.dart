import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/models/agent_model.dart';
import 'package:gb_lottery_b2b/src/common/repos/api_repository.dart';
import 'package:gb_lottery_b2b/src/common/repos/preferences_repository.dart';
import 'package:logger/logger.dart';

/// [ProfileRepository] handles fetching and updating agent profile information.
class ProfileRepository {
  final ApiRepository _apiRepository;
  final PreferencesRepository _preferencesRepository;
  final Logger _log = Logger();

  ProfileRepository(this._apiRepository, this._preferencesRepository);

  /// Fetches the current agent's profile using the stored USER_ID.
  Future<AgentModel> getProfile() async {
    try {
      final userId = _preferencesRepository.getPreference(Constants.store.USER_ID);
      _log.d("ProfileRepository::getProfile::Fetching for USER_ID: $userId");

      if (userId == null || userId.toString().isEmpty) {
        throw Exception("User ID not found. Please log in again.");
      }

      final endpoint = "${Constants.api.getAccountDetails}/$userId";
      final response = await _apiRepository.getRequest(endpoint);

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        
        // Handle cases where the agent might be nested or direct
        final agentData = data['agent'] != null
            ? Map<String, dynamic>.from(data['agent'])
            : Map<String, dynamic>.from(data);

        return AgentModel.fromJson(agentData);
      } else {
        throw Exception(response['message'] ?? 'Failed to load profile');
      }
    } catch (e) {
      _log.e("ProfileRepository::getProfile::Error: $e");
      rethrow;
    }
  }

  /// Updates the agent's profile details.
  Future<AgentModel> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final userId = _preferencesRepository.getPreference(Constants.store.USER_ID);
      final endpoint = "${Constants.api.getAccountDetails}/$userId";

      final payload = {
        "name": name,
        "email": email,
        "phone": phone,
      };

      _log.d("ProfileRepository::updateProfile::Path: $endpoint, Payload: $payload");
      
      final response = await _apiRepository.putRequest(
        url: endpoint,
        data: payload,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        final agentData = data['agent'] != null
            ? Map<String, dynamic>.from(data['agent'])
            : Map<String, dynamic>.from(data);

        return AgentModel.fromJson(agentData);
      } else {
        throw Exception(response['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      _log.e("ProfileRepository::updateProfile::Error: $e");
      rethrow;
    }
  }
}
