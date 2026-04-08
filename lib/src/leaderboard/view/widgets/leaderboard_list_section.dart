import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardListSection extends StatelessWidget {
  const LeaderboardListSection({super.key});

 @override
Widget build(BuildContext context) {
  final w = MediaQuery.of(context).size.width;
  final scale = w / 375;
  double s(double v) => v * scale;

  return Container(
    padding: EdgeInsets.symmetric(vertical: s(10)),
    decoration: BoxDecoration(
      color: ColorPalette.backgroundDark,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),

    // ✅ ONLY THIS SCROLLS
    child: ListView(
      children: [
        profileItem(context, s, "Rahul", "1,05,001", "4"),
        divider(s),

        profileItem(context, s, "Mani", "1,02,500", "5"),
        divider(s),

        profileItem(context, s, "Sasi", "98,450", "6"),
        divider(s),

        profileItem(context, s, "Ram", "95,200", "7"),
        divider(s),

        profileItem(context, s, "Kavi", "90,300", "8"),
        divider(s),

        profileItem(context, s, "Siva", "88,900", "9"),
        divider(s),

        profileItem(context, s, "Baranee", "85,700", "10"),
        divider(s),

        profileItem(context, s, "Aravind", "82,400", "11"),
        divider(s),

        profileItem(context, s, "Siva", "88,900", "9"),
        divider(s),

        profileItem(context, s, "Baranee", "85,700", "10"),
        divider(s),

        profileItem(context, s, "Aravind", "82,400", "11"),
      ],
    ),
  );
}

  Widget divider(double Function(double) s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s(7.5)),
      child: const Divider(color: Colors.white12),
    );
  }

  Widget profileItem(
    BuildContext context,
    double Function(double) s,
    String name,
    String amount,
    String rank,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s(14)),
      child: Row(
        children: [
          // Image.asset(
          //   "assets/images/leaderboard/avatar.webp",
          //   height: s(35),
          //   width: s(35),
          //   fit: BoxFit.contain,
          // ),m 
          Container(
            height: s(35),
            width: s(35),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.surface,
              image: const DecorationImage(
                image: AssetImage("assets/images/leaderboard/avatar.png"),
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
                  name,
                  style: GoogleFonts.dmSans(
                    color: ColorPalette.whitetext,
                    fontSize: s(14),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: s(1)),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/leaderboard/coin.png",
                      height: s(16),
                      width: s(16),
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: s(4)),
                    Text(
                      amount,
                      style: GoogleFonts.dmSans(
                        color: ColorPalette.whitetext,
                        fontSize: s(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                'assets/images/leaderboard/price.png',
                width: s(35),
                height: s(24),
                fit: BoxFit.contain,
              ),

              Positioned(
                top: -s(4),
                child: Container(
                  width: s(19),
                  height: s(19),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD1D5DC),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      rank,
                      style: GoogleFonts.dmSerifText(
                        fontSize: s(14),
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF234D79),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
