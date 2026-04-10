part of 'lottery_bloc.dart';

abstract class LotteryEvent extends Equatable {
  const LotteryEvent();

  @override
  List<Object?> get props => [];
}

class FetchLotteries extends LotteryEvent {}
