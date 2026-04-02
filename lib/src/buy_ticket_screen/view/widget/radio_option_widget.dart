import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class RadioOptionWidget extends StatelessWidget {
  final double Function(double) s;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const RadioOptionWidget({
    super.key,
    required this.s,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ✅ click works now
      child: Row(
        children: [
          /// 🔘 OUTER CIRCLE
          Container(
            width: s(18),
            height: s(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? ColorPalette.option
                  : ColorPalette.unselected, // unselected color
            ),
            child: Center(
              child: Container(
                width: s(14),
                height: s(14),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorPalette.backgroundDark,
                ),
                child: Center(
                  child: isSelected
                      ? Container(
                    width: s(8),
                    height: s(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.option,
                    ),
                  )
                      : const SizedBox(),
                ),
              ),
            ),
          ),
          SizedBox(width: s(10)),
          /// 📝 TEXT
          Text(
            text,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: s(14),
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              height: 20 / 14,
            ),
          ),
        ],
      ),
    );
  }
}