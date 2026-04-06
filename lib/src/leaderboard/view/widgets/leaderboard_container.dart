import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardContainer extends StatelessWidget {
  const LeaderboardContainer({super.key});

  Color getRankColor(String rank) {
    switch (rank) {
      case "1":
        return const Color(0xFFAD9537);
      case "2":
        return const Color(0xFF234D79);
      case "3":
        return const Color(0xFF8E3414);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        leaderboardItem(
          context,
          rank: "2",
          circleSize: s(24),
          rankTextSize: s(18),
          width: s(110),
          height: s(148),
          topImageWidth: s(43.0909),
          topImageHeight: s(29.2138),
          bottomImageHeight: s(80),
          bottomImageWidth: s(80),
          gap: s(10),
          gradientColors: const [
            Color(0xFF1C1B20),
            Color(0xFF1E2D40),
            Color(0xFF245B93),
          ],
          name: "Mani",
          amount: "1,05,001",
        ),

        leaderboardItem(
          context,
          rank: "1",
          circleSize: s(30),
          width: s(110),
          height: s(168),
          topImageWidth: s(54.581),
          topImageHeight: s(37.0043),
          bottomImageHeight: s(80),
          bottomImageWidth: s(80),
          gap: s(22),
          rankTextSize: s(22.8),
          gradientColors:  [
            Color(0xFF1C1B20),
            Color(0xFF70643A),
            Color(0xFFDFC55C),
          ],
          name: "Gopi",
          amount: "1,25,041",
        ),

        leaderboardItem(
          context,
          rank: "3",
          circleSize: s(24),
          width: s(110),
          height: s(148),
          topImageWidth: s(43.0909),
          rankTextSize: s(18),
          topImageHeight: s(29.2138),
          bottomImageHeight: s(80),
          bottomImageWidth: s(80),
          gap: s(10),
          gradientColors: const [
            Color(0xFF1C1B20),
            Color(0xFF993512),
            Color(0xFF934324),
          ],
          name: "Arul",
          amount: "1,08,041",
        ),
      ],
    );
  }

  Widget leaderboardItem(
    BuildContext context, {
    required double width,
    required double height,
    required double topImageWidth,
    required double topImageHeight,
    required double bottomImageWidth,
    required double bottomImageHeight,
    required List<Color> gradientColors,
    required String name,
    required String amount,
    required double gap,
    required double circleSize,
    required String rank,
    required double rankTextSize,
  }) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),

          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: s(40),
                child: SizedBox(
                  width: topImageWidth,
                  height: topImageHeight,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        'assets/images/leaderboard/price.webp',
                        width: topImageWidth,
                        height: topImageHeight,
                        fit: BoxFit.contain,
                      ),

                      Positioned(
                        top: -s(8),
                        child: Container(
                          width: circleSize,
                          height: circleSize,
                          decoration: BoxDecoration(
                            color: Color(0xFFD1D5DC),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                rank,
                                style: GoogleFonts.dmSerifText(
                                  fontSize: rankTextSize,
                                  fontWeight: FontWeight.w400,
                                  color: getRankColor(rank),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: topImageHeight + gap,
                bottom: s(-40),
                child: Image.asset(
                  'assets/images/leaderboard/men.webp',
                  width: bottomImageWidth,
                  height: bottomImageHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: s(7)),
        Text(
          name,
          style: GoogleFonts.dmSans(
            color: ColorPalette.whitetext,
            fontSize: s(12),
            fontWeight: FontWeight.w400,
          ),
        ),

        SizedBox(height: s(2)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/leaderboard/coin.webp',
              width: s(16),
              height: s(16),
            ),
            SizedBox(width: s(4)),
            Text(
              amount,
              style: GoogleFonts.dmSans(
                color: ColorPalette.whitetext,
                fontSize: s(12),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
