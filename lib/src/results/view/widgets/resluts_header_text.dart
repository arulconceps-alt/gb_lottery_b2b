import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class ReslutsHeaderText extends StatelessWidget {
  final String text;
  const ReslutsHeaderText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Text(
      text,
      style: GoogleFonts.dmSans(
        fontSize: s(14),
        color: ColorPalette.darktext,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class ReslutCellText extends StatelessWidget {
  final String text;
  const ReslutCellText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Text(
      text,
      style: GoogleFonts.dmSans(
        fontSize: s(14),
        color: ColorPalette.darktext,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class ResultsCircleHeader extends StatelessWidget {
  final String text;
  const ResultsCircleHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Container(
      width: s(26), 
      height: s(26),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B20),
        borderRadius: BorderRadius.circular(s(6)), 
      ),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: s(14),
          color: ColorPalette.whitetext,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class ResultsNumberBox extends StatelessWidget {
  final String text;
  const ResultsNumberBox(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: s(4)), 
      width: s(26), 
      height: s(26),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(s(6)), 
      ),
      child: Text(
        text,
       style: GoogleFonts.dmSans(
          fontSize: s(14),
          color: ColorPalette.whitetext,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}