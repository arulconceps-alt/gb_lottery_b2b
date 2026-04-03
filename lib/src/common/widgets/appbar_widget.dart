import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top, 
      ),
      decoration: BoxDecoration(
        color: ColorPalette.backgroundDark,
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: Container(
        height: s(60),
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
                  padding: EdgeInsets.all(s(8)),
                  child: Image.asset(
                    "assets/images/buy_ticket/back.webp",
                    height: s(24),
                    width: s(24),
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                  ),
                ),
              )
            else
              SizedBox(width: s(40)),

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

            rightWidget ?? SizedBox(width: s(40)),
          ],
        ),
      ),
    );
  }
}