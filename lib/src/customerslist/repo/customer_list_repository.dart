import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/models/customer_model.dart';
import 'package:gb_lottery_b2b/src/common/repos/api_repository.dart';
import 'package:logger/logger.dart';

class CustomerListResult {
  final List<CustomerModel> customers;
  final int total;

  CustomerListResult({required this.customers, required this.total});
}

class CustomerListRepository {
  final ApiRepository _apiRepository;
  final Logger _log = Logger();

  CustomerListRepository(this._apiRepository);

  Future<CustomerListResult> getCustomers({
    String roleName = '',
    String roleId = '',
    int page = 1,
    int limit = 10,
    String search = '',
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };

      if (roleName.isNotEmpty) {
        queryParams['roleName'] = roleName;
      }

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }

      _log.d("CustomerListRepository::getCustomers::Fetching with params: $queryParams");

      // Use the generic getAccountDetails endpoint
      final response = await _apiRepository.getRequest(
        Constants.api.getAccountDetails,
        queryParameters: queryParams,
      );

      _log.d("CustomerListRepository::getCustomers::Raw Response: $response");

      List docs = [];
      int total = 0;

      if (response is Map && response['success'] == true) {
        // Handle various response formats (data.docs, data.agents, data.results, etc.)
        final dataSection = response['data'];
        
        if (dataSection != null) {
          if (dataSection is List) {
            docs = dataSection;
            total = dataSection.length;
          } else if (dataSection is Map) {
            total = int.tryParse((dataSection['total'] ?? dataSection['count'] ?? 0).toString()) ?? 0;
            
            if (dataSection['docs'] is List) {
              docs = dataSection['docs'];
            } else if (dataSection['agents'] is List) {
              docs = dataSection['agents'];
            } else if (dataSection['users'] is List) {
              docs = dataSection['users'];
            } else if (dataSection['results'] is List) {
              docs = dataSection['results'];
            }
          }
        } else if (response['agents'] is List) {
           docs = response['agents'];
           total = int.tryParse((response['total'] ?? response['count'] ?? docs.length).toString()) ?? docs.length;
        } else if (response['users'] is List) {
           docs = response['users'];
           total = int.tryParse((response['total'] ?? response['count'] ?? docs.length).toString()) ?? docs.length;
        } else if (response['docs'] is List) {
           docs = response['docs'];
           total = int.tryParse((response['total'] ?? response['count'] ?? docs.length).toString()) ?? docs.length;
        }

        if (total > 0 && docs.isEmpty) {
          _log.w("CustomerListRepository::getCustomers::Total is $total but no items found in docs/agents/users/results. Response keys: ${response.keys}, Data keys: ${response['data']?.keys}");
        }
      }

      final customersList = docs.map((e) {
        try {
          return CustomerModel.fromJson(e as Map<String, dynamic>);
        } catch (err) {
          _log.e("CustomerListRepository::Mapping error: $err for item: $e");
          // Return a placeholder or empty model to keep the list moving
          return CustomerModel.empty().copyWith(name: "Invalid Data Format");
        }
      }).toList();

      return CustomerListResult(customers: customersList, total: total);
    } catch (e) {
      _log.e("CustomerListRepository::getCustomers::Error: $e");
      rethrow;
    }
  }

  /// Updates an agent's details using PUT
  Future<void> updateAgent(String id, Map<String, dynamic> data) async {
    try {
      final url = "${Constants.api.updateCustomer}/$id"; // e.g., /dealer/agents/ID
      await _apiRepository.putRequest(
        url: url,
        data: data,
      );
    } catch (e) {
      _log.e("CustomerListRepository::updateAgent::Error: $e");
      rethrow;
    }
  }

  /// Fetches available roles and returns a map of roleName to roleId.
  Future<Map<String, String>> getRolesMap() async {
    try {
      final response = await _apiRepository.getRequest(Constants.api.getRoles);
      
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
        }
      }

      if (rolesData != null) {
        for (var role in rolesData) {
          final name = (role['roleName'] ?? role['name'])?.toString();
          final id = (role['id'] ?? role['_id'])?.toString();

          if (name != null && id != null) {
            rolesMap[name.trim().toLowerCase()] = id;
          }
        }
      }

      return rolesMap;
    } catch (e) {
      _log.e("CustomerListRepository::getRolesMap::Error: $e");
      return {};
    }
  }
}
