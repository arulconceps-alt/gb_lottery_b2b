import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/resultinner/view/widgets/resluts_inner_lottry_table.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsInnerLottrySectionCard extends StatefulWidget {
  final String title;

  const ResultsInnerLottrySectionCard({super.key, required this.title});

  @override
  State<ResultsInnerLottrySectionCard> createState() =>
      _ResultsInnerLottrySectionCardState();
}

class _ResultsInnerLottrySectionCardState
    extends State<ResultsInnerLottrySectionCard> {
  Duration remainingTime = const Duration(hours: 2, minutes: 41, seconds: 55);
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime -= const Duration(seconds: 1);
        });
      } else {
        timer?.cancel();
      }
    });
  }

  String formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inHours)} : ${twoDigits(d.inMinutes % 60)} : ${twoDigits(d.inSeconds % 60)}";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(s(14)),
          decoration: BoxDecoration(
            color: const Color(0xFF2B2A33),
            borderRadius: BorderRadius.circular(s(16)),
          ),
          child: Column(
            children: [
              /// TOP ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// LEFT SIDE
                  Row(
                    children: [
                      Container(
                        width: s(50),
                        height: s(50),
                        decoration: const BoxDecoration(
                          color: ColorPalette.backgroundDark,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: s(12)),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.dmSans(
                              color: ColorPalette.whitetext,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              fontSize: s(16),
                            ),
                          ),
                           SizedBox(height: s(5)),
                          Text(
                            "Draw Result",
                            style: GoogleFonts.dmSans(
                              color: ColorPalette.darktext,
                              fontWeight: FontWeight.w400,
                              fontSize: s(12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.push('/buy_ticket'),
                    child: Container(
                      height: s(36),
                      //width: s(88),
                      padding: EdgeInsets.symmetric(
                        horizontal: s(15),
                        vertical: s(9),
                      ),
                      decoration: BoxDecoration(
                      color: ColorPalette.backgroundDark,
                        borderRadius: BorderRadius.circular(s(10)),
                      ),
                      child: Text(
                        "Play Now",
                        style: GoogleFonts.dmSans(
                          color: ColorPalette.whitetext,
                          fontWeight: FontWeight.w400,
                          fontSize: s(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: s(14)),

              /// BOTTOM SECTION
              Container(
                 //height: s(58),
                padding: EdgeInsets.all(s(12)),
                decoration: BoxDecoration(
                 color: ColorPalette.backgroundDark,
                  borderRadius: BorderRadius.circular(s(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Draw",
                          style: GoogleFonts.dmSans(
                            color: ColorPalette.darktext,
                            fontWeight: FontWeight.w400,
                            fontSize: s(12),
                          ),
                        ),
                        SizedBox(height: s(2)),
                        Text(
                          "03.00 PM",
                          style: GoogleFonts.dmSans(
                            color: ColorPalette.whitetext,
                            fontWeight: FontWeight.w600,
                            fontSize: s(12),
                          ),
                        ),
                      ],
                    ),
                     SizedBox(width: s(132)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: s(11),
                        vertical: s(9),
                      ),
                      decoration: BoxDecoration(
                        color: ColorPalette.surface,
                        borderRadius: BorderRadius.circular(s(6)),
                      ),
                      child: Text(
                        formatTime(remainingTime),
                        style: GoogleFonts.dmSans(
                          color: ColorPalette.whitetext,
                          fontWeight: FontWeight.w500,
                          fontSize: s(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: s(14)),
        const ResultInnerLotteryTable(),
      ],
    );
  }
}
