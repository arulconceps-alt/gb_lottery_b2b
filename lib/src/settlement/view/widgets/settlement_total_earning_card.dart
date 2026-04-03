import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';

class SettlementTotalEarningCard extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String imagePath;

  const SettlementTotalEarningCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Container(
      padding: EdgeInsets.only(
        left: s(25),
        top: s(20),
        right: s(30),
        bottom: s(27), 
      ),
      decoration: BoxDecoration(
        gradient: ColorPalette.buttonGradient,
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// TEXT 1 (single line, fully visible)
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text1,
                    maxLines: 1,
                    style: GoogleFonts.dmSans(
                      fontSize: s(16),
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.whitetext,
                    ),
                  ),
                ),

                SizedBox(height: s(4)),

                /// TEXT 2
                Text(
                  text2,
                  style: GoogleFonts.dmSans(
                    fontSize: s(48),
                    fontWeight: FontWeight.w700,
                    color: ColorPalette.whitetext,
                  ),
                ),

                SizedBox(height: s(4)),

                /// TEXT 3
                Text(
                  text3,
                  style: GoogleFonts.inter(
                    fontSize: s(16),
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.whitetext,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: s(19)),

          /// CIRCLE ICON
          Container(
            height: s(70),
            width: s(70),
            padding: EdgeInsets.all(s(15)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.whitetext,
            ),
            child: Image.asset(
              imagePath,
              height: s(21),
              width: s(18),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}