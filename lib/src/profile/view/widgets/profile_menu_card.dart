import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/login/repo/login_repository.dart';
import 'package:gb_lottery_b2b/src/login/bloc/login_bloc.dart';
import 'package:gb_lottery_b2b/src/common/services/services_locator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorPalette.backgroundDark,
            borderRadius: BorderRadius.circular(s(8)),
          ),
          child: Column(
            children: [
              _menuItem(
                s,
                iconPath: 'assets/images/profile/wallet.png',
                title: 'Wallet History',
                onTap: () => context.push('/wallet_screen'),
              ),
              _divider(s),

              _menuItem(
                s,
                iconPath: 'assets/images/profile/settlement.png',
                title: 'Settlement',
                onTap: () => context.push('/settlement'),
              ),
              _divider(s),

              _menuItem(
                s,
                iconPath: 'assets/images/profile/leardboard.png',
                title: 'Leaderboard',
                onTap: () => context.push('/leaderboard'),
              ),
              _divider(s),
              _menuItem(
                s,
                iconPath: 'assets/images/profile/purchase.png',
                title: 'Purchase History',
                onTap: () => context.push('/purchase_history_list'),
              ),
              _divider(s),
              _menuItem(
                s,
                iconPath: 'assets/images/profile/cart.png',
                title: 'Cart',
                onTap: () => context.push('/myCart'),
              ),
            ],
          ),
        ),

        SizedBox(height: s(26)),

        Container(
          decoration: BoxDecoration(
            color: ColorPalette.backgroundDark,
            borderRadius: BorderRadius.circular(s(8)),
          ),
          child: Column(
            children: [
              _menuItem(
                s,
                iconPath: 'assets/images/profile/notification.png',
                title: 'Notification',
                onTap: () => context.push('/notification_screen'),
              ),
              _divider(s),

              _menuItem(
                s,
                iconPath: 'assets/images/profile/language.png',
                title: 'Language',
              ),
              _divider(s),

              _menuItem(
                s,
                iconPath: 'assets/images/profile/terms.png',
                title: 'Terms & Conditions',
              ),
              _divider(s),

              _menuItem(
                s,
                iconPath: 'assets/images/profile/privacy.png',
                title: 'Privacy Policy',
              ),
              _divider(s),

              _menuItem(
                s,
                iconPath: 'assets/images/profile/logout.png',
                title: 'Logout',
                onTap: () {
                  showLogoutBottomSheet(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _menuItem(
    double Function(double) s, {
    required String iconPath,
    required String title,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(s(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: s(17), vertical: s(12)),
        child: Row(
          children: [
            Image.asset(iconPath, width: s(24), height: s(24)),

            SizedBox(width: s(12)),

            Expanded(
              child: Text(
                title,
                style: GoogleFonts.dmSans(
                  color: ColorPalette.whitetext,
                  fontSize: s(14),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            Image.asset(
              "assets/images/profile/right.png",
              height: s(20),
              width: s(20),
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider(double Function(double) s) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s(17)),
      child: Divider(
        color: ColorPalette.whitetext.withOpacity(0.10),
        thickness: 1,
        height: s(1),
      ),
    );
  }

  void showLogoutBottomSheet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            height: s(200),
            decoration: BoxDecoration(
              color: ColorPalette.backgroundDark,
              borderRadius: BorderRadius.vertical(top: Radius.circular(s(26))),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: s(38)),
                Text(
                  "Logout",
                  style: GoogleFonts.dmSans(
                    color: ColorPalette.whitetext,
                    fontWeight: FontWeight.w600,
                    fontSize: s(18),
                  ),
                ),

                SizedBox(height: s(16)),

                Text(
                  "Are you sure you want to logout ?",
                  style: GoogleFonts.dmSans(
                    color: ColorPalette.whitetext,
                    fontWeight: FontWeight.w400,
                    fontSize: s(12),
                  ),
                ),

                SizedBox(height: s(23)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s(40)),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: s(140),
                            height: s(40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF313038),
                              borderRadius: BorderRadius.circular(s(10)),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.dmSans(
                                color: ColorPalette.whitetext,
                                fontWeight: FontWeight.w500,
                                fontSize: s(16),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: s(11)),

                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.pop(context); // Close bottom sheet
                            await getIt<LoginRepository>().logout();
                            if (context.mounted) {
                              context.go('/login');
                            }
                          },
                          child: Container(
                            width: s(140),
                            height: s(40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: ColorPalette.buttonGradient,
                              borderRadius: BorderRadius.circular(s(10)),
                            ),
                            child: Text(
                              "Yes, Logout",
                              style: GoogleFonts.dmSans(
                                color: ColorPalette.whitetext,
                                fontWeight: FontWeight.w500,
                                fontSize: s(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
