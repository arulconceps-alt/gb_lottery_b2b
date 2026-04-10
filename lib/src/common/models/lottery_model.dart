class LotteryModel {
  final String id;
  final String drawName;
  final int cutoffTime;
  final String type;
  final String stateName;
  final List<String> days;
  final List<String> drawTimes;
  final String? drawDate;

  LotteryModel({
    required this.id,
    required this.drawName,
    required this.cutoffTime,
    required this.type,
    required this.stateName,
    required this.days,
    required this.drawTimes,
    this.drawDate,
  });

  factory LotteryModel.fromJson(Map<String, dynamic> json) {
    return LotteryModel(
      id: json['id'] ?? '',
      drawName: json['drawName'] ?? '',
      cutoffTime: json['cutoffTime'] ?? 0,
      type: json['type'] ?? '',
      stateName: json['stateName'] ?? '',
      days: List<String>.from(json['days'] ?? []),
      drawTimes: List<String>.from(json['drawTimes'] ?? []),
      drawDate: json['drawDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'drawName': drawName,
      'cutoffTime': cutoffTime,
      'type': type,
      'stateName': stateName,
      'days': days,
      'drawTimes': drawTimes,
      'drawDate': drawDate,
    };
  }
}
