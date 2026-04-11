part of 'lottery_bloc.dart';

enum LotteryStatus { initial, loading, success, failure }

class LotteryState extends Equatable {
  final LotteryStatus status;
  final List<LotteryModel> lotteries;
  final String message;

  const LotteryState({
    required this.status,
    required this.lotteries,
    required this.message,
  });

  static const LotteryState initial = LotteryState(
    status: LotteryStatus.initial,
    lotteries: [],
    message: '',
  );

  LotteryState copyWith({
    LotteryStatus Function()? status,
    List<LotteryModel> Function()? lotteries,
    String Function()? message,
  }) {
    return LotteryState(
      status: status != null ? status() : this.status,
      lotteries: lotteries != null ? lotteries() : this.lotteries,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object?> get props => [status, lotteries, message];
}
