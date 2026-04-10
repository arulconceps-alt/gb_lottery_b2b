import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/models/customer_model.dart';
import 'package:gb_lottery_b2b/src/common/repos/api_repository.dart';

class AddCustomerRepository {
  final ApiRepository _apiRepository;

  AddCustomerRepository(this._apiRepository);

  Future<void> addCustomer(CustomerModel customer) async {
    try {
      final response = await _apiRepository.postRequest(
        url: Constants.api.addCustomer,
        data: customer.toJson(),
        requestName: 'add_customer',
      );

      if (response['success'] != true) {
        throw Exception(response['message'] ?? 'Failed to add customer');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addMultipleCustomers(List<CustomerModel> customers) async {
    try {
      // If the API supports bulk add, we would use that.
      // Otherwise, we loop through them.
      for (var customer in customers) {
        await addCustomer(customer);
      }
    } catch (e) {
      rethrow;
    }
  }
}
