import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTextWithBack(title: "Terms & Conditions"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Agreement",
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),
            Text(
              "Terms of Service",
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 12),
            Text(
              "Last Updated: 07/04/2026",
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            /// 4️⃣ Description
            Text(
              "By using the app you agree to the Terms and Conditions. "
              "Please read them carefully before using our services. "
              "These terms govern your use of the application and all related services.",
              style: GoogleFonts.dmSans(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}