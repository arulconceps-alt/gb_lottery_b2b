import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String amount;
  final VoidCallback? onLeadingTap;

  const CommonAppBar({super.key, required this.amount, this.onLeadingTap});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return AppBar(
      backgroundColor: const Color(0xFF24232A),
      elevation: 0,
      centerTitle: true,

      leading: GestureDetector(
        onTap: onLeadingTap,
         child:
        // Image.asset(
        //   "assets/images/dashboard/menuicon.webp",
        //   height: s(24),
        //   width: s(24),
        //   fit: BoxFit.contain,
        // ),
        Icon(Icons.menu, color: ColorPalette.whitetext, size: s(24)),
      ),

      title: Image.asset(
        "assets/images/dashboard/gb_logo.webp",
        height: s(22),
        width: s(31),
        fit: BoxFit.contain,
      ),

      actions: [
        Padding(
          padding: EdgeInsets.only(right: s(12)),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: s(10), vertical: s(6)),
              decoration: BoxDecoration(
                gradient: ColorPalette.buttonGradient,
                borderRadius: BorderRadius.circular(s(10)),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/dashboard/wallet_icon.webp",
                    height: s(20),
                    width: s(20),
                  ),
                  SizedBox(width: s(9.5)),
                  Text(
                    amount,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: s(14),
                      color: ColorPalette.whitetext,
                    ),
                  ),
                  SizedBox(width: s(9.5)),
                  Image.asset(
                    "assets/images/dashboard/add_icon.webp",
                    height: s(20),
                    width: s(20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
