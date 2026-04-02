import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class SettlementMonthlyCard extends StatefulWidget {
  const SettlementMonthlyCard({super.key});

  @override
  State<SettlementMonthlyCard> createState() => _SettlementMonthlyCardState();
}

class _SettlementMonthlyCardState extends State<SettlementMonthlyCard> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    Widget buildRow(String title, String value, double progress) {
      return Padding(
        padding:  EdgeInsets.symmetric(horizontal: s(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.dmSans(
                    fontSize: s(16),
                    fontWeight: FontWeight.w400,
                      color: ColorPalette.whitetext,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.dmSans(
                    fontSize: s(16),
                    fontWeight: FontWeight.w600,
                     color: ColorPalette.primary,
                  ),
                ),
              ],
            ),
        
            SizedBox(height: s(12)),
        
            ClipRRect(
              borderRadius: BorderRadius.circular(s(8)),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: s(6),
                backgroundColor: ColorPalette.whitetext,
                valueColor: const AlwaysStoppedAnimation(ColorPalette.primary),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: s(414),
      decoration: BoxDecoration(
        color: ColorPalette.backgroundDark,
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedIndex = 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: s(12)),
                    decoration: BoxDecoration(
                      color: ColorPalette.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(s(8)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Month",
                        style: GoogleFonts.dmSans(
                          fontSize: s(16),
                          fontWeight: FontWeight.w500,
                          color: selectedIndex == 0
                              ? ColorPalette.primary
                              : ColorPalette.whitetext,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// Divider
              Container(
                width: 1,
                height: s(40),
                color: ColorPalette.whitetext.withOpacity(0.2),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedIndex = 1),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: s(12)),
                    decoration: BoxDecoration(
                      color: ColorPalette.surface,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(s(8)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Daily",
                        style: GoogleFonts.dmSans(
                          fontSize: s(16),
                          fontWeight: FontWeight.w500,
                          color: selectedIndex == 1
                              ? ColorPalette.primary
                              : ColorPalette.whitetext,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: s(4)),

          /// HEADER
          Padding(
            padding: EdgeInsets.symmetric(vertical: s(16), horizontal: s(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedIndex == 0 ? "Monthly Earnings" : "Daily Earnings",
                  style: GoogleFonts.dmSans(
                    fontSize: s(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: s(30),
                  width: s(30),
                  padding: EdgeInsets.all(s(6)),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                   color: ColorPalette.surface,
                  ),
                  child: Image.asset(
                    "assets/images/settlement/calender.webp", 
                    height: s(18),
                    width: s(18),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: s(8)),

          /// DATA
          buildRow("Month", "January, 2026", 1.0),
          SizedBox(height: s(15)),
          buildRow("Total Sales", "₹2,45,000", 0.85),
          SizedBox(height: s(15)),
          buildRow("Commission %15", "₹35,420", 0.65),
          SizedBox(height: s(15)),
          buildRow("Bonus", "₹2,000", 0.8),
          SizedBox(height: s(15)),
          buildRow("Total Earnings", "₹37,420", 0.75),
        ],
      ),
    );
  }
}
