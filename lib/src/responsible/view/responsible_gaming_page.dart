import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponsibleGamingPage extends StatelessWidget {
  const ResponsibleGamingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTextWithBack(title: "Responsible Gaming"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            "Coming Soon",
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}