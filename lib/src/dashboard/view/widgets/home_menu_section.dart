import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMenuSection extends StatelessWidget {
  final String imagePath;
  final String title;
  final double imageheight;
  final double imagewidth;
  final double spaceheight;
  final VoidCallback? onTap;

  const HomeMenuSection({
    super.key,
    required this.imagePath,
    required this.title,
    required this.imageheight,
    required this.imagewidth,
    required this.spaceheight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // height: s(70),
          // width: s(105),  
          margin: EdgeInsets.symmetric(horizontal: s(14)),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1B20),
            borderRadius: BorderRadius.circular(s(8)),
            border: Border.all(
              color: ColorPalette.primary,
              width: 1,
            ),
          ),
          child: Padding(
            padding:  EdgeInsets.only( top: s(11), bottom: s(6)),
            child: Column(
              children: [
                Image.asset(
                  imagePath,
                  height: s(imageheight),
                  width: s(imagewidth),
                ),
                SizedBox(height: s(spaceheight)),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    color: ColorPalette.primary,
                    fontSize: s(10),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}