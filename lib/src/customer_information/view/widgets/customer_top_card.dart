import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerTopCard extends StatelessWidget {
  final String topTitle;
  final String topValue;
  final Gradient topGradient;

  final String bottomTitle;
  final String bottomValue;
  final Gradient bottomGradient;

  const CustomerTopCard({
    super.key,
    required this.topTitle,
    required this.topValue,
    required this.topGradient,
    required this.bottomTitle,
    required this.bottomValue,
    required this.bottomGradient,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Column(
      children: [
        _card(
          s,
          title: topTitle,
          value: topValue,
          gradient: topGradient,
        ),
    
        SizedBox(height: s(12)),
        _card(
          s,
          title: bottomTitle,
          value: bottomValue,
          gradient: bottomGradient,
        ),
      ],
    );
  }

  
  Widget _card(
    double Function(double) s, {
    required String title,
    required String value,
    required Gradient gradient,
  }) {
    return Container(
      width: double.infinity,
      height: s(128),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(s(8)),
      ),
      padding: EdgeInsets.all(s(12)),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// TITLE
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: s(16),
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          SizedBox(height: s(6)),
          Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontSize: s(32),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}