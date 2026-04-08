import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreenCard extends StatelessWidget {
  const WalletScreenCard({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    // --- DATA ---
    double totalMoney = 300000;
    double spentMoney = 262580; // Changing this moves the tooltip
    double ratio = (spentMoney / totalMoney).clamp(0.0, 1.0);

    // Logic for the Red Zone warning text
    bool isRedZone = ratio > 0.60;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s(16)),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(s(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 1. TOP SECTION (Amount)
          Text("Total Money", style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(14))),
          Text("₹3,00,000", style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(40), fontWeight: FontWeight.bold)),

          SizedBox(height: s(20)),

          /// 2. PROGRESS BAR
          ClipRRect(
            borderRadius: BorderRadius.circular(s(10)),
            child: Row(
              children: [
                Expanded(flex: 35, child: Container(height: s(12), color: Colors.green)),
                Expanded(flex: 25, child: Container(height: s(12), color: Colors.orange)),
                Expanded(flex: 25, child: Container(height: s(12), color: Colors.red)),
                Expanded(flex: 15, child: Container(height: s(12), color: Colors.white)),
              ],
            ),
          ),

          /// 3. MOVING TOOLTIP SECTION
          LayoutBuilder(
            builder: (context, constraints) {
              double barWidth = constraints.maxWidth;
              double tooltipWidth = s(110); // Adjust based on your design

              // Calculate exactly where the center of the tooltip should be
              double leftPosition = (barWidth * ratio) - (tooltipWidth / 2);

              // Prevent tooltip from clipping off the screen edges
              leftPosition = leftPosition.clamp(0.0, barWidth - tooltipWidth);

              return SizedBox(
                height: s(100), // Height for the warning text + tooltip
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [

                    /// THE WARNING TEXT (Only shows in Red Zone)
                    if (isRedZone)
                      Positioned(
                        top: s(10),
                        left: 0,
                        child: Text(
                          "Your Money is too Low",
                          style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(14)),
                        ),
                      ),

                    /// THE MOVING TOOLTIP
                    Positioned(
                      left: leftPosition, // This makes it move
                      top: s(5),
                      child: Column(
                        children: [
                          // 1. The "Pointy" Indicator (Red Dot)
                          Container(
                            width: s(8),
                            height: s(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF0000),
                              shape: BoxShape.circle,
                            ),
                          ),

                          // 2. The Tooltip Body (Gold Card)
                          Container(
                            width: tooltipWidth,
                            padding: EdgeInsets.symmetric(vertical: s(8)),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
                              ),
                              borderRadius: BorderRadius.circular(s(8)),
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
                              ],
                            ),
                            child: Column(
                              children: [
                                Text("Spent Money", style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(10), fontWeight: FontWeight.w600)),
                                Text("₹2,62,580", style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(16), fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}