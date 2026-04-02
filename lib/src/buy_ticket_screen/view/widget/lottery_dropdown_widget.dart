import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryDropdownWidget extends StatelessWidget {
  final double Function(double) s;
  final String text;
  final VoidCallback? onTap;

  const LotteryDropdownWidget({
    super.key,
    required this.s,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: s(66),
        padding: EdgeInsets.symmetric(horizontal: s(16)),
        decoration: BoxDecoration(
          color: ColorPalette.backgroundDark,
          borderRadius: BorderRadius.circular(s(10)),
          border: Border.all(
            color: ColorPalette.border,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            /// 📝 TEXT
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.dmSans(
                  color: const Color(0xFF9F9F9F),
                  fontSize: s(15),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  height: 20 / 15,
                ),
              ),
            ),
            /// 🔽 DROPDOWN ICON
            Image.asset(
              "assets/images/buy_ticket/ep_arrow-down-bold.webp",
              height:s(16) ,
              width: s(16),
            ),
          ],
        ),
      ),
    );
  }
}