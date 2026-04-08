import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationCardItem extends StatelessWidget {
  final double Function(double) s;
  final String title;
  final String message;
  final String time;

  const NotificationCardItem({
    super.key,
    required this.s,
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: s(343),
      height: s(120),
      padding: EdgeInsets.symmetric(horizontal: s(12)),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 1. ICON BOX (Fixed Top 18)
          Padding(
            padding: EdgeInsets.only(top: s(18)),
            child: Container(
              width: s(40),
              height: s(40),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1B20),
                borderRadius: BorderRadius.circular(s(8)),
              ),
              child: Center(
                child: Image.asset(
                 "assets/images/notification/wallet_icon.png",
                  height: s(24),
                  width: s(24),
                ),
              ),
            ),
          ),

          SizedBox(width: s(9)), // Distance to text (Left 61)

          /// 2. TEXT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TIME (Top 12)
                Padding(
                  padding: EdgeInsets.only(top: s(12)),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      time,
                      style: GoogleFonts.dmSans(
                        color: const Color(0x999F9F9F),
                        fontSize: s(12),
                        fontWeight: FontWeight.w400,
                        height: 1.0, // Remove line-height padding
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -s(7)),
                  child: Text(
                    title,
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: s(16),
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Transform.translate(
                  offset: Offset(0, -s(6)),
                  child: SizedBox(
                    width: s(249),
                    child: Text(
                      message,
                      style: GoogleFonts.dmSans(
                        color: const Color(0xFF9F9F9F),
                        fontSize: s(12),
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}