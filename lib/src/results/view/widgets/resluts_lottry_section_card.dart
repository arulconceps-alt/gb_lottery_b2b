import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/results/view/widgets/resluts_lottry_table.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LotterySectionCard extends StatelessWidget {
  final String title;

  const LotterySectionCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: s(50), 
                  height: s(50),
                  decoration: const BoxDecoration(
                    color: Color(0xFF313038),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: s(12)), 
                Text(
                  title,
                  style: GoogleFonts.dmSans(
                    color: ColorPalette.whitetext,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: s(16), 
                  ),
                ),
              ],
            ),
            GestureDetector(
             onTap: () => context.push('/reslutinner'),
              child: Container(
                    height: s(36),
                padding: EdgeInsets.symmetric(
                  horizontal: s(16),
                  vertical: s(9),
                ), 
                decoration: BoxDecoration(
                  color:  ColorPalette.backgroundDark,
                  borderRadius: BorderRadius.circular(s(10)), 
                ),
                child: Text(
                  "More",
                  maxLines: 1,
                  softWrap: true,
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

        /// Table
        const ReslutsLottryTable(),
      ],
    );
  }
}