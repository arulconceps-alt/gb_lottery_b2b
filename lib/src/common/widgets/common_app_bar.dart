import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String amount;
  final VoidCallback? onLeadingTap;

  const CommonAppBar({super.key, required this.amount, this.onLeadingTap});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return AppBar(
      backgroundColor:  ColorPalette.backgroundDark,
      elevation: 0,

      leading: GestureDetector(
        onTap: onLeadingTap,
        child: Icon(Icons.menu, color: ColorPalette.whitetext, size: s(24)),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          Container(
            height: s(32),
            width: s(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(s(6)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(s(6)),
              child: Image.asset(
                "assets/images/dashboard/a1.webp",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: s(8)),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: GoogleFonts.inter(
                  color: ColorPalette.whitetext,
                  fontSize: s(9),
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "Userid-Name",
                style: GoogleFonts.inter(
                  color: ColorPalette.whitetext,
                  fontSize: s(11),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),

      actions: [
        Padding(
          padding: EdgeInsets.only(right: s(12)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: s(10),
                  vertical: s(6),
                ),
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
              SizedBox(width: s(18.3)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: ()=> context.push('/notification_screen'),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          "assets/images/dashboard/bell.webp",
                          height: s(19.86),
                          width: s(19.86),
                        ),
                    
                        Positioned(
                          right: -4,
                          top: -4,
                          child: Container(
                            height: s(12),
                            width: s(12),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "9+",
                              style: GoogleFonts.inter(
                                color: ColorPalette.whitetext,
                                fontSize: s(6),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Image.asset(
                    "assets/images/dashboard/bell_bottom.webp",
                    height: s(1.52),
                    width: s(3.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
