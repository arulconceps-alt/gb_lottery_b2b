import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryDropdownWidget extends StatelessWidget {
  final double Function(double) s;
  final String text;
  final List<String> items;
  final ValueChanged<String> onSelected;

  const LotteryDropdownWidget({
    super.key,
    required this.s,
    required this.text,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: PopupMenuButton<String>(
        onSelected: onSelected,
        color: ColorPalette.backgroundDark,
        constraints: BoxConstraints(
          maxHeight: s(180), // 🔥 scroll after 3+ items
          minWidth: MediaQuery.of(context).size.width - s(32),
        ),
        itemBuilder: (context) {
          return items.map((item) {
            return PopupMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: s(14),
                ),
              ),
            );
          }).toList();
        },
        child: Row(
          children: [
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
            Image.asset(
              "assets/images/buy_ticket/ep_arrow-down-bold.png",
              height: s(16),
              width: s(16),
            ),
          ],
        ),
      ),
    );
  }
}