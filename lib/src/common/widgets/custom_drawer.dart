import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return SafeArea(
      child: Drawer(
        width: s(300),
        backgroundColor:  ColorPalette.backgroundDark,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: s(80),
                color: ColorPalette.background,
                child: Padding(
                  padding:  EdgeInsets.all(s(16)),
                  child: Row(
                    children: [
                      Container(
                        height: s(48),
                        width: s(48),
                        decoration: BoxDecoration(
                          //shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/dashboard/user.webp",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: s(16)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Username",
                              style: GoogleFonts.archivo(
                                fontSize: s(14),
                                fontWeight: FontWeight.w400,
                                color: ColorPalette.whitetext,
                              ),
                            ),
                            SizedBox(height: s(2)),
                            Text(
                              "+91- 99988776655",
                              style: GoogleFonts.archivo(
                                fontSize: s(12),
                                fontWeight: FontWeight.w400,
                                color: ColorPalette.whitetext,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: s(54)),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          "assets/images/dashboard/cross.webp",
                          width: s(16),
                          height: s(16),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _menuItem(
                      "assets/images/dashboard/profile_icon.webp",
                      "Profile",
                      s,
                      onTap: () => context.push('/profile'),
                    ),
                    _menuItem(
                      "assets/images/dashboard/customer_icon.webp",
                      "Customers",
                      s,
                       onTap: () => context.push('/customer'),
                    ),
                    _menuItem(
                      "assets/images/dashboard/purchase.webp",
                      "Purchase Ticket",
                      s,
                      onTap: () => context.push('/buy_ticket'),
                    ),
                    _menuItem(
                      "assets/images/dashboard/wallet_icon.webp",
                      "Wallet",
                      s,
                    ),
                    _menuItem(
                      "assets/images/dashboard/settle_icon.webp",
                      "Settlement",
                      s,
                      onTap: () => context.push('/settlement'),
                    ),
                    _menuItem(
                      "assets/images/dashboard/leadboard.webp",
                      "Leaderboard",
                      s,
                    ),
                    _menuItem(
                      "assets/images/dashboard/support.webp",
                      "Support Chat",
                      s,
                    ),
                    _menuItem(
                      "assets/images/dashboard/terms_condition.webp",
                      "Terms & Conditions",
                      s,
                    ),
                    _menuItem(
                      "assets/images/dashboard/privacy.webp",
                      "Privacy",
                      s,
                    ),
                    _menuItem(
                      "assets/images/dashboard/responsible.webp",
                      "Responsible Gaming",
                      s,
                    ),
      
                    //SizedBox(height: s(10)),
                    Container(
                      height: s(48),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: ColorPalette.background),
                    ),
      
                    _menuItem(
                      "assets/images/dashboard/profile_icon.webp",
                      "Relation manager",
                      s,
                    ),
                    Container(
                      height: s(48),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: ColorPalette.background),
                    ),
                    _menuItem(
                      "assets/images/dashboard/logout.webp",
                      "Logout",
                      s,
                      isLogout: true,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(s(16)),
              //   child: Row(
              //     children: [
              //       Image.asset(
              //         "assets/images/dashboard/logout.webp",
              //         width: s(24),
              //         height: s(24),
              //         fit: BoxFit.contain,
              //       ),
              //       SizedBox(width: s(10)),
              //       Text(
              //         "Logout",
              //         style: GoogleFonts.inter(
              //           fontSize: s(14),
              //           color: Colors.red,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(
  String iconPath,
  String title,
  double Function(double) s, {
  bool isLogout = false,
  VoidCallback? onTap, 
}) {
  return ListTile(
    leading: Image.asset(
      iconPath,
      width: s(24),
      height: s(24),
       color: isLogout ? Colors.red : ColorPalette.whitetext,
      fit: BoxFit.contain,
    ),
    title: Text(
      title,
      style: GoogleFonts.inter(
        fontSize: s(14),
        color: isLogout ? Colors.red : ColorPalette.whitetext,
        fontWeight: FontWeight.w400,
      ),
    ),
    trailing: isLogout
        ? null
        : Image.asset(
            "assets/images/dashboard/right.webp",
            width: s(20),
            height: s(20),
            fit: BoxFit.contain,
          ),
    onTap: onTap,
  );
}
}
