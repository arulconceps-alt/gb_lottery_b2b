import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/app_theme.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardGameCard extends StatelessWidget {
  final String image;
  final String title;
  final String prize;

  const DashboardGameCard({
    super.key,
    required this.image,
    required this.title,
    required this.prize,
  });

  @override
  Widget build(BuildContext context) {
    final themedata = theme.context.of(context);
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Container(
      width: s(167),
      height: s(160),
      padding: EdgeInsets.all(s(10)),
      decoration: BoxDecoration(
        color: themedata.cardColor,
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: s(50),
                width: s(50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: s(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyles.dmSans12SemiBold.copyWith(
                        fontSize: s(12),
                        fontStyle: FontStyle.italic,
                        color: themedata.textTheme.bodyLarge?.color,
                      ),
                    ),
                     SizedBox(height: s(1)),
                    Text(
                      "Win Price",
                      style: TextStyles.dmSans12.copyWith(
                        fontSize: s(12),
                        color: themedata.textTheme.bodyMedium?.color,
                      ),
                    ),
                     SizedBox(height: s(1)),
                    Text(
                      prize,
                      style: TextStyles.dmSans12SemiBold.copyWith(
                        fontSize: s(12),
                        color: themedata.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: s(8)),
          Text(
            "Next draw starts in :",
            style: TextStyles.dmSans10.copyWith(
              fontSize: s(10),
              color: themedata.textTheme.bodyMedium?.color,
            ),
          ),

          SizedBox(height: s(4)),
          Row(
            children: [
              _timeBox("01h", s, themedata),
              SizedBox(width: s(3)),
              Text(
                ":",
                style: TextStyles.dmSans12SemiBold.copyWith(
                  fontSize: s(12),
                  color: themedata.textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(width: s(5)),
              _timeBox("01m", s, themedata),
              SizedBox(width: s(3)),
              Text(
                ":",
                style: GoogleFonts.dmSans(
                  fontSize: s(12),
                  fontWeight: FontWeight.w600,
                  color: themedata.textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(width: s(5)),
              _timeBox("30s", s, themedata),
            ],
          ),

           SizedBox(height: s(8)),

          GestureDetector(
            onTap: () => context.push('/buy_ticket'),
            child: Container(
              width: double.infinity,
              height: s(34),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: themedata.colorScheme.surface,
                borderRadius: BorderRadius.circular(s(6)),
              ),
              child: Text(
                "Play Now",
                style: TextStyles.dmSans12SemiBold.copyWith(
                  fontSize: s(12),
                  color: themedata.textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeBox(String text, double Function(double) s, ThemeData themedata) {
    return Container(
      width: s(40),
      height: s(18),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: themedata.colorScheme.surface,
        borderRadius: BorderRadius.circular(s(4)),
      ),
      child: Text(
        text,
        style: TextStyles.dmSans10SemiBold.copyWith(
          fontSize: s(10),
          fontStyle: FontStyle.italic,
          color: themedata.textTheme.bodyLarge?.color,
        ),
      ),
    );
  }
}
