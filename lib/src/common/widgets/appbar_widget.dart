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
    return SafeArea(
      child: Container(
        height: s(91),
        width: double.infinity,
        padding: EdgeInsets.only(bottom: s(3)),

        decoration: BoxDecoration(
          color: const Color(0xFF0F1116),
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.1),
              width: 0.5,
            ),
          ),
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: s(16)),
          child: Row(
            children: [
              /// 🔙 BACK BUTTON
              if (showBack)
                GestureDetector(
                  onTap: onBackTap ?? () => Navigator.pop(context),
                  child: Image.asset(
                    "assets/images/buy_ticket/back.webp",
                    height: s(24),
                    width: s(24),
                  ),
                )
              else
                SizedBox(width: s(18)),

              /// 📝 TITLE
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: s(17),
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      letterSpacing: -0.17,
                    ),
                  ),
                ),
              ),

              /// ⚙️ RIGHT SIDE
              rightWidget ??
                  SizedBox(width: s(20)), // keeps alignment perfect
            ],
          ),
        ),
      ),
    );
  }
}