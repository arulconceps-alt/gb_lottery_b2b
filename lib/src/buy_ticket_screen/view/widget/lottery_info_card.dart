import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryInfoCard extends StatelessWidget {
  final double Function(double) s;

  const LotteryInfoCard({super.key, required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: s(120)), // Better than fixed height
      padding: EdgeInsets.fromLTRB(s(12), s(11), s(12), s(12)),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: IntrinsicHeight( // Ensures the divider matches the column height
        child: Row(
          children: [
            /// LEFT SIDE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kerala Lottery",
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: s(14),
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                      letterSpacing: -0.14,
                    ),
                  ),
                  SizedBox(height: s(2)),
                  Text(
                    "19/01/2026",
                    style: GoogleFonts.dmSans(
                      color: const Color(0xFF9F9F9F),
                      fontSize: s(12),
                      fontStyle: FontStyle.italic,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: s(15)),
                  Row(
                    children: [
                      _numberBox("5"),
                      SizedBox(width: s(12)),
                      _numberBox("3"),
                      SizedBox(width: s(12)),
                      _numberBox("1"),
                    ],
                  ),
                ],
              ),
            ),

            /// CENTER VERTICAL DIVIDER (Dashed style tip: use Opacity + CustomPaint if needed)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s(12)),
              child: VerticalDivider(
                color: Colors.white.withOpacity(0.2),
                thickness: 1,
                width: 1,
              ),
            ),

            /// RIGHT SIDE
            SizedBox(
              width: s(104), // Match the Timer box width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: s(6)),
                  Text(
                    "Time remaining",
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: s(12),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: s(6)),
                  _timerDisplay("02 : 41 : 55"),
                  SizedBox(height: s(8)),
                  Text(
                    "02:00 PM",
                    style: GoogleFonts.dmSans(
                      color: const Color(0xFFDFC45C),
                      fontSize: s(12),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _numberBox(String num) {
    return Container(
      width: s(41),  // Figma: Fixed (41px)
      height: s(40), // Figma: Fixed (40px)
      alignment: Alignment.center, // Vertical alignment: Middle
      decoration: BoxDecoration(
        color: const Color(0xFF313038), // Figma: Background color
        borderRadius: BorderRadius.circular(s(6)), // Figma: Radius 6px
      ),
      child: Text(
        num,
        textAlign: TextAlign.center,
        style: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: s(14),
          fontWeight: FontWeight.w500,
          height: 1.30, // Maintains consistency with other 14px text
          letterSpacing: s(-0.14), // Matches -1% spacing
        ),
      ),
    );
  }

  Widget _timerDisplay(String time) {
    return Container(
      width: s(104),  // Figma: Fixed (104px)
      height: s(36), // Figma: Fixed (36px)
      alignment: Alignment.center, // Vertically and horizontally middle
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(s(6)), // Figma: Radius 6px
      ),
      child: Text(
        time,
        textAlign: TextAlign.center,
        style: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: s(14),
          fontWeight: FontWeight.w500,
          // Using a tight height helps with precise vertical centering
          height: 1.0,
        ),
      ),
    );
  }
}