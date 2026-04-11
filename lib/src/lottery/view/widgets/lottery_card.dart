import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/app_theme.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';
import 'package:gb_lottery_b2b/src/common/models/lottery_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryCard extends StatefulWidget {
  final LotteryModel lottery;

  const LotteryCard({
    super.key,
    required this.lottery,
  });

  @override
  State<LotteryCard> createState() => _LotteryCardState();
}

class _LotteryCardState extends State<LotteryCard> {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _calculateRemainingTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _calculateRemainingTime();
        });
      }
    });
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    DateTime? drawDateTime;

    if (widget.lottery.drawDate != null) {
      // Special Lottery
      try {
        drawDateTime = DateTime.parse(widget.lottery.drawDate!);
        // If drawTimes also provided, combine them
        if (widget.lottery.drawTimes.isNotEmpty) {
          final timeParts = widget.lottery.drawTimes[0].split(':');
          if (timeParts.length == 2) {
            drawDateTime = DateTime(
              drawDateTime.year,
              drawDateTime.month,
              drawDateTime.day,
              int.parse(timeParts[0]),
              int.parse(timeParts[1]),
            );
          }
        }
      } catch (e) {
         // Fallback if parsing fails
      }
    } else if (widget.lottery.drawTimes.isNotEmpty) {
      // Regular Lottery - find next time today or tomorrow
      for (var timeStr in widget.lottery.drawTimes) {
        final parts = timeStr.split(':');
        if (parts.length == 2) {
          var drawTime = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(parts[0]),
            int.parse(parts[1]),
          );

          if (drawTime.isAfter(now)) {
            drawDateTime = drawTime;
            break;
          }
        }
      }

      // If no more draws today, pick the first one tomorrow
      if (drawDateTime == null && widget.lottery.drawTimes.isNotEmpty) {
        final parts = widget.lottery.drawTimes[0].split(':');
        drawDateTime = DateTime(
          now.year,
          now.month,
          now.day + 1,
          int.parse(parts[0]),
          int.parse(parts[1]),
        );
      }
    }

    if (drawDateTime != null) {
      _remainingTime = drawDateTime.difference(now);
      if (_remainingTime.isNegative) {
        _remainingTime = Duration.zero;
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _getPlaceholderImage(String stateName) {
    if (stateName.toLowerCase().contains("assam")) {
      return "assets/images/dashboard/arunachal_lottry.webp";
    } else if (stateName.toLowerCase().contains("kerala")) {
      return "assets/images/dashboard/kerala_lottry.webp";
    }
    return "assets/images/dashboard/arunachal_lottry.webp";
  }

  @override
  Widget build(BuildContext context) {
    final themedata = theme.context.of(context);
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final hours = _remainingTime.inHours.toString().padLeft(2, '0');
    final minutes = (_remainingTime.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime.inSeconds % 60).toString().padLeft(2, '0');

    return Container(
      width: s(167),
      height: s(160),
      padding: EdgeInsets.all(s(10)),
      decoration: BoxDecoration(
        color: themedata.cardColor,
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: s(50),
                width: s(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(_getPlaceholderImage(widget.lottery.stateName)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: s(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.lottery.drawName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.dmSans12SemiBold.copyWith(
                        fontSize: s(12),
                        color: themedata.textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: s(1)),
                    Text(
                      "Win Price",
                      style: TextStyles.dmSans12.copyWith(
                        fontSize: s(12),
                        color: themedata.textTheme.bodyMedium?.color,
                      ),
                    ),
                    SizedBox(height: s(1)),
                    Text(
                      "₹40,000",
                      style: TextStyles.dmSans12SemiBold.copyWith(
                        fontSize: s(12),
                        color: themedata.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: s(8)),
          Text(
            "Next draw starts in :",
            style: TextStyles.dmSans10.copyWith(
              fontSize: s(10),
              color: themedata.textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(height: s(4)),
          Row(
            children: [
              _timeBox("$hours h", s, themedata),
              SizedBox(width: s(3)),
              Text(
                ":",
                style: TextStyles.dmSans12SemiBold.copyWith(
                  fontSize: s(12),
                  color: themedata.textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(width: s(5)),
              _timeBox("$minutes m", s, themedata),
              SizedBox(width: s(3)),
              Text(
                ":",
                style: GoogleFonts.dmSans(
                  fontSize: s(12),
                  fontWeight: FontWeight.w600,
                  color: themedata.textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(width: s(5)),
              _timeBox("$seconds s", s, themedata),
            ],
          ),
          SizedBox(height: s(8)),
          GestureDetector(
            onTap: () => context.push('/buy_ticket'),
            child: Container(
              width: double.infinity,
              height: s(34),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: themedata.colorScheme.surface,
                borderRadius: BorderRadius.circular(s(6)),
              ),
              child: Text(
                "Play Now",
                style: TextStyles.dmSans12SemiBold.copyWith(
                  fontSize: s(12),
                  color: themedata.textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeBox(String text, double Function(double) s, ThemeData themedata) {
    return Container(
      width: s(40),
      height: s(18),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: themedata.colorScheme.surface,
        borderRadius: BorderRadius.circular(s(4)),
      ),
      child: Text(
        text,
        style: TextStyles.dmSans10SemiBold.copyWith(
          fontSize: s(10),
          color: themedata.textTheme.bodyLarge?.color,
        ),
      ),
    );
  }
}
