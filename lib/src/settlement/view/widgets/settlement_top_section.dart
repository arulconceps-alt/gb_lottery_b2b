import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class SettlementTopSection extends StatelessWidget {
  final List<Map<String, String>> items;

  const SettlementTopSection({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;


    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: s(16),
        mainAxisSpacing: s(16),
        childAspectRatio: 1.05,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return Container(
          padding: EdgeInsets.only(bottom : s(16), left: s(10), top: s(12)),
          decoration: BoxDecoration(
            color: ColorPalette.backgroundDark,
            borderRadius: BorderRadius.circular(s(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon box
              Container(
                height: s(40),
                width: s(40),
                padding: EdgeInsets.all(s(10)),
                decoration: BoxDecoration(
                  color: ColorPalette.background,
                  borderRadius: BorderRadius.circular(s(8)),
                ),
                child: Image.asset(
                  item['icon'] ?? '',
                  height: s(20),
                  width: s(20),
                ),
              ),

              SizedBox(height: s(14)),

              // Title (text1)
              Text(
                item['text1'] ?? '',
                style: GoogleFonts.dmSans(
                  fontSize: s(14),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.darktext,
                ),
              ),

              SizedBox(height: s(5)),

              // Value (text2)
              Text(
                item['text2'] ?? '',
                style: GoogleFonts.dmSans(
                  fontSize: s(16),
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.whitetext,
                ),
              ),

              SizedBox(height: s(5)),

              // Sub text (text3)
              Text(
                item['text3'] ?? '',
                 style: GoogleFonts.dmSans(
                  fontSize: s(14),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.darktext,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}