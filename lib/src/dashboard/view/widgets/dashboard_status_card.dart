import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardStatusCard extends StatelessWidget {
  final List<Map<String, String>> items;

  const DashboardStatusCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final List<Color> text3Colors = [
      const Color(0xFF00C950),
      const Color(0xFF6A7282),
      const Color(0xFFAD46FF),
      const Color(0xFF9F9F9F),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(s(16)),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: s(16),
        mainAxisSpacing: s(16),
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return Container(
          padding: EdgeInsets.all(s(12)),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2B33),
            borderRadius: BorderRadius.circular(s(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: s(40),
                width: s(40),
                padding: EdgeInsets.all(s(8)),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(s(10)),
                ),
                child: Image.asset(item['icon'] ?? '', fit: BoxFit.contain),
              ),

              SizedBox(height: s(14)),

              Text(
                item['text1'] ?? '',
                style: GoogleFonts.dmSans(
                  fontSize: s(14),
                  fontWeight: FontWeight.w400,
                  color: index == 3
                      ? ColorPalette.whitetext
                      : ColorPalette.darktext,
                ),
              ),

              SizedBox(height: s(5)),

              if (index != 3) ...[
                Text(
                  item['text2'] ?? '',
                  style: GoogleFonts.dmSans(
                    fontSize: s(16),
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.whitetext,
                  ),
                ),
                SizedBox(height: s(5)),
                Text(
                  item['text3'] ?? '',
                  style: GoogleFonts.dmSans(
                    fontSize: s(14),
                    fontWeight: FontWeight.w400,
                    color: text3Colors[index],
                  ),
                ),
              ],

              if (index == 3) ...[
                SizedBox(height: s(5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item['text2'] ?? '',
                        style: GoogleFonts.dmSans(
                          fontSize: s(14),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.darktext,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/dashboard/right_arrow.webp",
                      height: s(16),
                      width: s(16),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
