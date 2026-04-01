import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileUserInfoCard extends StatelessWidget {
  final String name;
  final String id;
  final String initial;
  final Color backgroundColor;

  const ProfileUserInfoCard({
    super.key,
    required this.name,
    required this.id,
    required this.initial,
    this.backgroundColor = const Color(0xFF24232A),
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Container(
      width: double.infinity,
      height: s(80),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Row(
        children: [
          SizedBox(width: s(16)),
          Container(
            width: s(56),
            height: s(56),
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: GoogleFonts.lato(
                color: ColorPalette.whitetext,
                fontWeight: FontWeight.w500,
                fontSize: s(24),
              ),
            ),
          ),

          SizedBox(width: s(13)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.dmSans(
                  color: ColorPalette.whitetext,
                  fontWeight: FontWeight.w600,
                  fontSize: s(16),
                ),
              ),
              SizedBox(height: s(1)),
              Text(
                id,
                style: GoogleFonts.dmSans(
                  color: ColorPalette.darktext,
                  fontWeight: FontWeight.w400,
                  fontSize: s(14),
                ),
              ),
            ],
          ),
          SizedBox(width: s(132)),
          Container(
            width: s(40),
            height: s(40),
            padding: EdgeInsets.all(s(11)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: ColorPalette.buttonGradient,
            ),
            child: Image.asset(
              'assets/images/profile/edit.webp',
              width: s(18),
              height: s(18),
            ),
          ),
        ],
      ),
    );
  }
}
