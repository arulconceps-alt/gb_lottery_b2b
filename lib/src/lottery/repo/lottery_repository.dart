import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/models/lottery_model.dart';
import 'package:gb_lottery_b2b/src/common/repos/api_repository.dart';

class LotteryRepository {
  final ApiRepository _apiRepository;

  LotteryRepository(this._apiRepository);

  Future<List<LotteryModel>> getLotteries() async {
    try {
      final response = await _apiRepository.getRequest(
        Constants.api.lotteries,
        baseUrl: Constants.api.LOTTERY_BASE_URL,
      );

      if (response['success'] == true && response['data'] != null) {
        final List<dynamic> data = response['data'];
        return data.map((json) => LotteryModel.fromJson(json)).toList();
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch lotteries');
      }
    } catch (e) {
      rethrow;
    }
  }
}
