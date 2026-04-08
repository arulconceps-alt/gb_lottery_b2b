import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';

class CustomerTopSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onButtonTap;

  const CustomerTopSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.dmSans(
                fontSize: s(18),
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: ColorPalette.whitetext,
              ),
            ),
            SizedBox(height: s(6)),
            Text(
              subtitle,
              style: GoogleFonts.dmSans(
                fontSize: s(16),
                fontWeight: FontWeight.w400,
                color: ColorPalette.darktext.withValues(alpha: .60),
              ),
            ),
          ],
        ),
        Row(
          children: [
            /// BUTTON
            GestureDetector(
              onTap: onButtonTap,
              child: Container(
                height: s(46),
                width: s(127),
                padding: EdgeInsets.symmetric(
                  horizontal: s(12),
                  vertical: s(6),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(s(8)),
                  gradient: ColorPalette.buttonGradient,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/customer_list/add.png", 
                      height: s(20),
                      width: s(20),
                      fit: BoxFit.contain,
                    ),
                     SizedBox(width: s(8)),
                    Text(
                      buttonText,
                      style: GoogleFonts.dmSans(
                        fontSize: s(16),
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.whitetext,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
