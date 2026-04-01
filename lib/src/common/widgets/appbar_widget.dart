import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppbarWidget extends StatelessWidget {
  final double Function(double) s;
  final String title;
  final bool showBack;
  final VoidCallback? onBackTap;
  final Widget? rightWidget;

  const AppbarWidget({
    super.key,
    required this.s,
    required this.title,
    this.showBack = false,
    this.onBackTap,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    // We remove SafeArea from here and handle it in the Scaffold/PreferredSize
    // so the background color extends behind the status bar for a "Pro" look.
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top, // This manually adds the Status Bar height
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B20), // Matches your app's dark theme
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: Container(
        height: s(60), // Fixed height for the content area
        padding: EdgeInsets.symmetric(horizontal: s(16)),
        child: Row(
          children: [
            /// 🔙 BACK BUTTON
            if (showBack)
              GestureDetector(
                onTap: onBackTap ?? () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(s(8)), // Larger tap target
                  child: Image.asset(
                    "assets/images/buy_ticket/back.webp",
                    height: s(24),
                    width: s(24),
                    // If image is missing, use Icon as fallback:
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                  ),
                ),
              )
            else
              SizedBox(width: s(40)),

            /// 📝 TITLE
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: s(17),
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.18,
                ),
              ),
            ),

            /// ⚙️ RIGHT SIDE
            rightWidget ?? SizedBox(width: s(40)),
          ],
        ),
      ),
    );
  }
}