import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/widgets/common_app_bar.dart';
import 'package:gb_lottery_b2b/src/common/widgets/custom_drawer.dart';
import 'package:gb_lottery_b2b/src/profile/view/widgets/profile_menu_card.dart';
import 'package:gb_lottery_b2b/src/profile/view/widgets/profile_user_info_card.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFF1C1B20),
      appBar: CommonAppBar(
        amount: "₹200",
        onLeadingTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: s(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: s(23)),
              Text(
                "Profile",
                style: GoogleFonts.dmSans(
                  color: ColorPalette.whitetext,
                  fontWeight: FontWeight.w700,
                  fontSize: s(18),
                ),
              ),
              SizedBox(height: s(14)),
              ProfileUserInfoCard(
                name: "Baranee",
                id: "Id : 50250",
                initial: "B",
              ),
               SizedBox(height: s(20)),
              ProfileMenuCard(),
               SizedBox(height: s(150)),
            ],
          ),
        ),
      ),
    );
  }
}
