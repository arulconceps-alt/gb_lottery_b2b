import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarTextWithBack extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onBackTap;
  final String title;

  const AppBarTextWithBack({super.key, this.onBackTap, required this.title});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return AppBar(
      backgroundColor:  ColorPalette.backgroundDark,
      elevation: 0,
      leading: GestureDetector(
        onTap: onBackTap ?? () => context.pop(),
        child: Image.asset(
          "assets/images/dashboard/back.webp",
          height: s(24),
          width: s(24),
        ),
      ),

      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.dmSans(
          fontSize: s(17),
          fontWeight: FontWeight.w500,
          color: ColorPalette.whitetext,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
