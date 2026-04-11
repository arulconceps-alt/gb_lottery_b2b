import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/models/customer_model.dart';
import 'package:gb_lottery_b2b/src/common/repos/api_repository.dart';
import 'package:logger/logger.dart';

class AddCustomerRepository {
  final ApiRepository _apiRepository;
  final Logger _log = Logger();

  AddCustomerRepository(this._apiRepository);

  /// Fetches available roles and returns a map of roleName to roleId.
  Future<Map<String, String>> getRolesMap() async {
    try {
      final response = await _apiRepository.getRequest(Constants.api.getRoles);
      
      _log.d("AddCustomerRepository::getRolesMap::Raw Response: $response");

      final Map<String, String> rolesMap = {};
      List? rolesData;

      if (response is List) {
        rolesData = response;
      } else if (response is Map) {
        final data = response['data'];
        if (data is List) {
          rolesData = data;
        } else if (data is Map && data['docs'] is List) {
          rolesData = data['docs'];
        } else if (response['roles'] is List) {
          rolesData = response['roles'];
        } else if (response['data'] == null && response.containsKey('roleName')) {
          rolesData = [response];
        }
      }

      if (rolesData != null) {
        for (var role in rolesData) {
          final name = (role['roleName'] ?? 
                        role['name'] ?? 
                        role['label'] ?? 
                        role['title'])?.toString();
          
          final id = (role['id'] ?? 
                      role['_id'] ?? 
                      role['roleId'] ?? 
                      role['value'])?.toString();

          if (name != null && id != null) {
            rolesMap[name.trim().toLowerCase()] = id;
          }
        }
      }

      _log.d("AddCustomerRepository::getRolesMap::Final Mapped Roles: $rolesMap");
      return rolesMap;
    } catch (e) {
      _log.e("AddCustomerRepository::getRolesMap::Error: $e");
      return {};
    }
  }

  /// Adds one or more customers using the bulk endpoint with dynamic role resolution.
  Future<void> addCustomers(List<CustomerModel> customers) async {
    try {
      final rolesMap = await getRolesMap();
      
      String userRoleId = rolesMap['user'] ?? 
                          rolesMap['customer'] ?? 
                          rolesMap['agent'] ?? 
                          '';
                               
      String moderatorRoleId = rolesMap['moderator'] ?? 
                               rolesMap['subadmin'] ?? 
                               rolesMap['admin'] ??
                               '';

      if (userRoleId.isEmpty && rolesMap.isNotEmpty) {
        userRoleId = rolesMap.values.first;
      }
      if (moderatorRoleId.isEmpty && rolesMap.isNotEmpty) {
        moderatorRoleId = rolesMap.containsKey('moderator') ? rolesMap['moderator']! : userRoleId;
      }

      _log.d("AddCustomerRepository::addCustomers::Resolved IDs -> User: $userRoleId, Moderator: $moderatorRoleId");

      final List<Map<String, dynamic>> payload = customers.map((c) {
        String finalRoleId = c.type.toLowerCase() == 'moderator' 
            ? moderatorRoleId 
            : userRoleId;

        final Map<String, dynamic> userMap = {
          "name": c.name,
          "phone": c.phone,
          "roleId": finalRoleId,
        };

        // ONLY include email if it has a value. 
        // Sending an empty string "" causes duplicate key errors for null/empty emails in some backends.
        if (c.email != null && c.email!.trim().isNotEmpty) {
          userMap["email"] = c.email!.trim();
        }
        if (c.pincode != null && c.pincode!.trim().isNotEmpty) {
          userMap["pincode"] = c.pincode!.trim();
        }
        if (c.address != null && c.address!.trim().isNotEmpty) {
          userMap["address"] = c.address!.trim();
        }

        return userMap;
      }).toList();

      _log.d("AddCustomerRepository::addCustomers::Final Payload: $payload");

      final response = await _apiRepository.postRequest(
        url: Constants.api.addAgentBulk,
        data: {"users": payload}, 
        isRaw: true,
        requestName: 'bulk_add_agents',
      );

      _log.d("AddCustomerRepository::addCustomers::API Response: $response");

      bool hasFailed = false;
      String errorMsg = 'Failed to add customers';

      if (response['success'] != true) {
        hasFailed = true;
        errorMsg = response['message'] ?? errorMsg;
      } else if (response['data'] != null && 
                 response['data']['failed'] != null && 
                 (response['data']['failed'] as num) > 0) {
        hasFailed = true;
        if (response['data']['results'] != null) {
          final results = response['data']['results'] as List;
          for (var res in results) {
            if (res['success'] == false) {
              errorMsg = res['error'] ?? errorMsg;
              break;
            }
          }
        }
      }

      if (hasFailed) {
        throw Exception(errorMsg);
      }
    } catch (e) {
      _log.e("AddCustomerRepository::addCustomers::Error: $e");
      rethrow;
    }
  }

  Future<void> addSingleCustomer(CustomerModel customer) async {
    return addCustomers([customer]);
  }
}
