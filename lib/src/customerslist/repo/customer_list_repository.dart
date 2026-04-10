import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/models/customer_model.dart';
import 'package:gb_lottery_b2b/src/common/repos/api_repository.dart';
import 'package:logger/logger.dart';

class CustomerListRepository {
  final ApiRepository _apiRepository;
  final Logger _log = Logger();

  CustomerListRepository(this._apiRepository);

  Future<List<CustomerModel>> getCustomers({
    String roleName = 'User',
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _apiRepository.getRequest(
        Constants.api.getAccountDetails,
        queryParameters: {
          'roleName': roleName,
          'page': page,
          'limit': limit,
        },
      );

      _log.d("CustomerListRepository::getCustomers::Raw Response: $response");

      List docs = [];

      if (response is List) {
        docs = response;
      } else if (response is Map) {
        if (response['success'] == true || response.containsKey('data')) {
          final data = response['data'];
          if (data is List) {
            docs = data;
          } else if (data is Map) {
            if (data['docs'] is List) {
              docs = data['docs'];
            } else if (data['agents'] is List) {
              docs = data['agents'];
            } else if (data['users'] is List) {
              docs = data['users'];
            } else if (data['data'] is List) {
              docs = data['data'];
            } else if (data['data'] is Map && data['data']['docs'] is List) {
              docs = data['data']['docs'];
            }
          }
        } else if (response['docs'] is List) {
          docs = response['docs'];
        }
      }

      if (docs.isEmpty) {
        _log.w("CustomerListRepository::getCustomers::No documents found in response matching known patterns.");
      }
      
      return docs.map((e) {
        try {
          return CustomerModel.fromJson(Map<String, dynamic>.from(e));
        } catch (err) {
          _log.e("CustomerListRepository::Mapping error: $err for data: $e");
          return CustomerModel.empty().copyWith(name: "Parse Error");
        }
      }).toList();
    } catch (e) {
      _log.e("CustomerListRepository::getCustomers::Error: $e");
      rethrow;
    }
  }
}
