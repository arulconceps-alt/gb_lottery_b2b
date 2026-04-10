import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/login/repo/login_repository.dart';
import 'package:gb_lottery_b2b/src/profile/bloc/profile_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gb_lottery_b2b/src/common/services/services_locator.dart';

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
        backgroundColor: ColorPalette.backgroundDark,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: s(80),
                color: ColorPalette.background,
                child: Padding(
                  padding: EdgeInsets.all(s(16)),
                  child: Row(
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          final user = state.user;
                          final initial = user.name.isNotEmpty
                              ? user.name[0].toUpperCase()
                              : "?";

                          return Container(
                            height: s(48),
                            width: s(48),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette.surface,
                            ),
                            child: Center(
                              child: Text(
                                initial,
                                style: GoogleFonts.dmSans(
                                  fontSize: s(28),
                                  color: ColorPalette.whitetext,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: s(16)),
                      Expanded(
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            final user = state.user;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.name.isEmpty ? "Username" : user.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.archivo(
                                    fontSize: s(14),
                                    fontWeight: FontWeight.w400,
                                    color: ColorPalette.whitetext,
                                  ),
                                ),
                                SizedBox(height: s(2)),
                                Text(
                                  user.phone.isEmpty
                                      ? "+91- 99988776655"
                                      : "+91- ${user.phone}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.archivo(
                                    fontSize: s(12),
                                    fontWeight: FontWeight.w400,
                                    color: ColorPalette.whitetext,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          "assets/images/drawer/cross.png",
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
                      "assets/images/drawer/profile_icon.png",
                      "Profile",
                      s,
                      onTap: () => context.push('/profile'),
                    ),
                    _menuItem(
                      "assets/images/drawer/customer_icon.png",
                      "Customers",
                      s,
                       onTap: () => context.push('/customer'),
                    ),
                    _menuItem(
                      "assets/images/drawer/purchase.png",
                      "Purchase Ticket",
                      s,
                      onTap: () => context.push('/buy_ticket'),
                    ),
                    _menuItem(
                      "assets/images/drawer/wallet_icon.png",
                      "Wallet",
                      s,
                        onTap: () => context.push('/wallet_screen'),
                    ),
                    _menuItem(
                      "assets/images/drawer/settle_icon.png",
                      "Settlement",
                      s,
                      onTap: () => context.push('/settlement'),
                    ),
                    _menuItem(
                      "assets/images/drawer/leadboard.png",
                      "Leaderboard",
                      s,
                      onTap: () => context.push('/leaderboard'),
                    ),
                    // _menuItem(
                    //   "assets/images/dashboard/support.webp",
                    //   "Support Chat",
                    //   s,
                    // ),
                    _menuItem(
                      "assets/images/drawer/terms_condition.png",
                      "Terms & Conditions",
                      s,
                      onTap: () => context.push('/terms'),
                    ),
                    _menuItem(
                      "assets/images/drawer/privacy.png",
                      "Privacy",
                      s,
                      onTap: () => context.push('/privacy'),
                    ),
                    _menuItem(
                      "assets/images/drawer/responsible.png",
                      "Responsible Gaming",
                      s,
                      onTap: () => context.push('/responsiblegaming'),
                    ),
      
                    Container(
                      height: s(48),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: ColorPalette.background),
                    ),
      
                    _menuItem(
                      "assets/images/drawer/profile_icon.png",
                      "Relation manager",
                      s,
                       onTap: () => context.push('/relationmanager'),
                    ),
                    Container(
                      height: s(48),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: ColorPalette.background),
                    ),
                    _menuItem(
                      "assets/images/drawer/logout.png",
                      "Logout",
                      s,
                      isLogout: true,
                      onTap: () async {
                        await getIt<LoginRepository>().logout();
                        if (context.mounted) {
                          context.go('/login');
                        }
                      },
                    ),
                  ],
                ),
              ),
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
      style: GoogleFonts.dmSans(
        fontSize: s(14),
        color: isLogout ? Colors.red : ColorPalette.whitetext,
        fontWeight: FontWeight.w400,
      ),
    ),
    trailing: isLogout
        ? null
        : Image.asset(
            "assets/images/drawer/right.png",
            width: s(20),
            height: s(20),
            fit: BoxFit.contain,
          ),
    onTap: onTap,
  );
}
}
