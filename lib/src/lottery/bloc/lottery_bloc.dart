import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/common/models/lottery_model.dart';
import 'package:gb_lottery_b2b/src/lottery/repo/lottery_repository.dart';
import 'package:logger/logger.dart';

part 'lottery_event.dart';
part 'lottery_state.dart';

class LotteryBloc extends Bloc<LotteryEvent, LotteryState> {
  final LotteryRepository _lotteryRepository;
  final _log = Logger();

  LotteryBloc(this._lotteryRepository) : super(LotteryState.initial) {
    on<FetchLotteries>(_onFetchLotteries);
  }

  Future<void> _onFetchLotteries(
    FetchLotteries event,
    Emitter<LotteryState> emit,
  ) async {
    if (state.status == LotteryStatus.loading) return;

    _log.d('LotteryBloc::_onFetchLotteries::Fetching lotteries');
    try {
      emit(state.copyWith(status: () => LotteryStatus.loading));
      
      final lotteries = await _lotteryRepository.getLotteries();
      
      emit(state.copyWith(
        status: () => LotteryStatus.success,
        lotteries: () => lotteries,
      ));
    } catch (e) {
      _log.e('LotteryBloc::_onFetchLotteries::Error: $e');
      emit(state.copyWith(
        status: () => LotteryStatus.failure,
        message: () => e.toString(),
      ));
    }
  }
}
