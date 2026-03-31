import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class WhatsGbBox extends StatelessWidget {
  const WhatsGbBox({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final List<Map<String, String>> items = [
      {"icon": "assets/images/dashboard/card.webp", "text": "Card"},
      {"icon": "assets/images/dashboard/sports.webp", "text": "Sports"},
      {"icon": "assets/images/dashboard/lottry.webp", "text": "Lottry"},
      {"icon": "assets/images/dashboard/casino.webp", "text": "Casino"},
      {"icon": "assets/images/dashboard/horse.webp", "text": "Horse"},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(items.length, (index) {
        final item = items[index];

        return Padding(
          padding: EdgeInsets.only(
            right: index != items.length - 1 ? s(21) : 0,
          ),
          child: Column(
            children: [
              Container(
                width: s(48),
                height: s(60),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: ColorPalette.whitetext,
                    width: s(1),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(s(50)),
                    topRight: Radius.circular(s(50)),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    item["icon"] ?? "",
                    height: s(60), 
                    width: s(48),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: s(6)),

              Text(
                item["text"] ?? "",
                style: GoogleFonts.inter(
                  fontSize: s(9),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.whitetext,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}