import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/widgets/common_app_bar.dart';
import 'package:gb_lottery_b2b/src/common/widgets/custom_drawer.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/add_customer_section.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/dashboard_fantasy_scroll_section.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/dashboard_game_card.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/dashboard_status_card.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/pure_lucky_section.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/whats_gb_box.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    return Scaffold(
       key: _scaffoldKey, // 👈 ADD KEY
       drawer: const CustomDrawer(), 
      appBar: CommonAppBar(
        amount: "₹200",
        onLeadingTap: () {
           _scaffoldKey.currentState?.openDrawer(); 
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: s(27)),
            DashboardStatusCard(
              items: [
                {
                  "icon": "assets/images/dashboard/today_sales.webp",
                  "text1": "Today's Sales",
                  "text2": "₹12,450",
                  "text3": "+12.5%",
                },
                {
                  "icon": "assets/images/dashboard/settlement.webp",
                  "text1": "Settlement",
                  "text2": "₹35,420",
                  "text3": "this month",
                },
                {
                  "icon": "assets/images/dashboard/total_customer.webp",
                  "text1": "Total Customers",
                  "text2": "25004",
                  "text3": "+8",
                },
                {
                  "icon": "assets/images/dashboard/buy_tickets.webp",
                  "text1": "Buy Tickets",
                  "text2": "Purchase from\ndistributor",
                  "text3": "+12.5%",
                },
              ],
            ),
            SizedBox(width: s(18)),
            AddCustomerSection(
              title: "Add Customer",
              subtitle: "Register new customer",
            ),
            SizedBox(height: s(30)),
            Text(
              "ABC Game",
              style: GoogleFonts.dmSans(fontSize: s(16),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
               color: ColorPalette.primary),
            ), 
            SizedBox(height: s(12)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s(20)),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: s(9),
                mainAxisSpacing: s(10),
                children: const [
                  DashboardGameCard(
                    image: "assets/images/dashboard/arunachal_lottry.webp",
                    title: "Arunachal",
                    prize: "₹40,000",
                  ),
                  DashboardGameCard(
                    image: "assets/images/dashboard/kerala_lottry.webp",
                    title: "Kerala",
                    prize: "₹40,000",
                  ),
                  DashboardGameCard(
                    image: "assets/images/dashboard/arunachal_lottry.webp",
                    title: "Arunachal",
                    prize: "₹40,000",
                  ),
                  DashboardGameCard(
                    image: "assets/images/dashboard/kerala_lottry.webp",
                    title: "Kerala",
                    prize: "₹40,000",
                  ),
                   DashboardGameCard(
                    image: "assets/images/dashboard/arunachal_lottry.webp",
                    title: "Arunachal",
                    prize: "₹40,000",
                  ),
                  DashboardGameCard(
                    image: "assets/images/dashboard/kerala_lottry.webp",
                    title: "Kerala",
                    prize: "₹40,000",
                  ),
                ],
              ),
            ),
            SizedBox(height: s(33)),
            Text(
              "YZABC Game",
              style: GoogleFonts.dmSans(fontSize: s(16),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
               color: ColorPalette.primary),
            ), 
            SizedBox(height: s(12)),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: s(20)),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: s(9),
                mainAxisSpacing: s(10),
                children: const [
                  DashboardGameCard(
                    image: "assets/images/dashboard/arunachal_lottry.webp",
                    title: "Arunachal",
                    prize: "₹40,000",
                  ),
                  DashboardGameCard(
                    image: "assets/images/dashboard/kerala_lottry.webp",
                    title: "Kerala",
                    prize: "₹40,000",
                  ),
                  DashboardGameCard(
                    image: "assets/images/dashboard/arunachal_lottry.webp",
                    title: "Arunachal",
                    prize: "₹40,000",
                  ),
                  DashboardGameCard(
                    image: "assets/images/dashboard/kerala_lottry.webp",
                    title: "Kerala",
                    prize: "₹40,000",
                  ),
                   DashboardGameCard(
                    image: "assets/images/dashboard/arunachal_lottry.webp",
                    title: "Arunachal",
                    prize: "₹40,000",
                  ),
                  DashboardGameCard(
                    image: "assets/images/dashboard/kerala_lottry.webp",
                    title: "Kerala",
                    prize: "₹40,000",
                  ),
                ],
              ),
            ),
            SizedBox(height: s(40)),
            Text(
              "What's in GB ",
              style: GoogleFonts.dmSans(fontSize: s(16),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
               color: ColorPalette.primary),
            ), 
            SizedBox(height: s(20)),
           const WhatsGbBox(),

            SizedBox(height: s(33)),
            Text(
              "Fantasy Sports",
              style: GoogleFonts.dmSans(fontSize: s(16),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
               color: ColorPalette.primary),
            ),  
             SizedBox(height: s(1)),
            Text(
              "Build your team. Play smart. Win real rewards.",
              style: GoogleFonts.dmSans(fontSize: s(12),
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
               color: ColorPalette.whitetext),
            ),  
            SizedBox(height: s(27)),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: s(20)),
              child: DashboardFantasyScrollSection(),
            ),
             SizedBox(height: s(42)),
            Text(
              "Pure Luck - Instant results.",
              style: GoogleFonts.dmSans(fontSize: s(16),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
               color: ColorPalette.primary),
            ),  
             SizedBox(height: s(1)),
            Text(
              "No strategy. Just spin and see",
              style: GoogleFonts.dmSans(fontSize: s(10),
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
               color: ColorPalette.whitetext),
            ),  
            SizedBox(height: s(10)),
            DashboradPureluckySectionCard()
          ],
        ),
      ),
    );
  }
}
