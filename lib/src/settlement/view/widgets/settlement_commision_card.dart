import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class SettlementCommissionCard extends StatelessWidget {
  const SettlementCommissionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Container(
      width: s(344),
      height: s(368),
      padding: EdgeInsets.all(s(16)),
      decoration: BoxDecoration(
        color: ColorPalette.backgroundDark,
        borderRadius: BorderRadius.circular(s(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Commission Structure',
            style: GoogleFonts.dmSans(
              fontSize: s(18),
              fontWeight: FontWeight.w600,
              color: ColorPalette.whitetext,
            ),
          ),
          SizedBox(height: s(16)),
          _buildItem(
            context,
            s,
            'Base Commission',
            'On all ticket sales',
            '15%',
          ),
          SizedBox(height: s(12)),
          _buildItem(
            context,
            s,
            'Performing Bonus',
            'On Monthly sales above ₹2L',
            '+₹2000',
          ),
          SizedBox(height: s(12)),
          _buildItem(
            context,
            s,
            'Target for Next Bonus',
            'Monthly Sales target',
            '₹3L',
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    double Function(double) s,
    String label,
    String subLabel,
    String value,
  ) {
    return Container(
      height: s(88),
      padding: EdgeInsets.symmetric(horizontal: s(15), vertical: s(19)),
      decoration: BoxDecoration(
        color: ColorPalette.border,
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.dmSans(
                  fontSize: s(16),
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.whitetext,
                ),
              ),
              SizedBox(height: s(6)),
              Text(
                subLabel,
                style: GoogleFonts.dmSans(
                  fontSize: s(14),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.darktext,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.dmSans(
              fontSize: s(20),
              fontWeight: FontWeight.w700,
              color: ColorPalette.primary,
            ),
          ),
        ],
      ),
    );
  }
}
