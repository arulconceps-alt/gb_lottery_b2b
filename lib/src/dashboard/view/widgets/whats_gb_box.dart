import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class WhatsGbBox extends StatelessWidget {
  const WhatsGbBox({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final List<Map<String, String>> items = [
      {"imagepath": "assets/images/dashboard/card.webp", "text": "Card"},
      {"imagepath": "assets/images/dashboard/sports.webp", "text": "Sports"},
      {"imagepath": "assets/images/dashboard/lottry.webp", "text": "Lottry"},
      {"imagepath": "assets/images/dashboard/casino.webp", "text": "Casino"},
      {"imagepath": "assets/images/dashboard/horse.webp", "text": "Horse"},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(items.length, (index) {
          final item = items[index];

          return Padding(
            padding: EdgeInsets.only(
              right: index != items.length - 1 ? s(10) : 0,
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/dashboard/frame.webp",
                      height: s(47),
                      width: s(59),
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      item["imagepath"] ?? "",
                      height: s(42),
                      width: s(52),
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(height: s(6)),
                Text(
                  item["text"] ?? "",
                  style: TextStyles.dmSans10SemiBold.copyWith(
                    fontSize: s(10),
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
