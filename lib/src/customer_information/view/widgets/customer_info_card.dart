import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerInfoCard extends StatelessWidget {
  final Map<String, String> data;

  const CustomerInfoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.backgroundDark,
        borderRadius: BorderRadius.circular(s(12)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: s(50),
            padding: EdgeInsets.symmetric(vertical: s(14)),
            decoration: BoxDecoration(
              color: const Color(0xFF313038),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(s(12)),
                topRight: Radius.circular(s(12)),
              ),
            ),
            child: Center(
              child: Text(
                "Customer Information",
                style: GoogleFonts.dmSans(
                  fontSize: s(18),
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.primary,
                ),
              ),
            ),
          ),

          Column(
            children: data.entries.toList().asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              return _row(
                s,
                item.key,
                item.value,
                isLast: index == data.length - 1,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _row(
    double Function(double) s,
    String title,
    String value, {
    bool isLast = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: ColorPalette.whitetext.withOpacity(0.10),
                  width: 0.5,
                ),
              ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  vertical: s(12),
                  horizontal: s(12),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: s(14),
                    color: ColorPalette.darktext,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            Container(
              width: 0.5,
              color: ColorPalette.whitetext.withOpacity(0.10),
            ),

            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  vertical: s(12),
                  horizontal: s(12),
                ),
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: s(14),
                    color: ColorPalette.darktext,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
