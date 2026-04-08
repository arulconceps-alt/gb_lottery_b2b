import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/app_theme.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';
import 'package:gb_lottery_b2b/src/common/widgets/common_app_bar.dart';
import 'package:gb_lottery_b2b/src/common/widgets/custom_drawer.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/dashboard_carousal.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/dashboard_fantasy_scroll_section.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/dashboard_game_card.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/dashboard_top_section.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/home_menu_section.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/pure_lucky_section.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/whats_gb_box.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final themedata = theme.context.of(context);
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    return Scaffold(
      backgroundColor: themedata.scaffoldBackgroundColor,
      key: _scaffoldKey,
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
            SizedBox(height: s(22)),
            DashboardTopSection(),
            SizedBox(height: s(21)),
            DashboardCarousel(),
            // SizedBox(height: s(10)),
            // DashboardStatusCard(
            //   items: [
            //     {
            //       "icon": "assets/images/dashboard/today_sales.webp",
            //       "text1": "Today's Sales",
            //       "text2": "₹12,450",
            //       "text3": "+12.5%",
            //     },
            //     {
            //       "icon": "assets/images/dashboard/settlement.webp",
            //       "text1": "Settlement",
            //       "text2": "₹35,420",
            //       "text3": "this month",
            //     },
            //     {
            //       "icon": "assets/images/dashboard/total_customer.webp",
            //       "text1": "Total Customers",
            //       "text2": "25004",
            //       "text3": "+8",
            //     },
            //     {
            //       "icon": "assets/images/dashboard/buy_tickets.webp",
            //       "text1": "Buy Tickets",
            //       "text2": "Purchase from\ndistributor",
            //       "text3": "+12.5%",
            //     },
            //   ],
            // ),
            // SizedBox(height: s(18)),
            // AddCustomerSection(
            //   title: "Add Customer",
            //   subtitle: "Register new customer",
            // ),
            SizedBox(height: s(23)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s(16)),
              child: Row(
                children: [
                  HomeMenuSection(
                    imagePath: "assets/images/dashboard/people.png",
                    title: "Add Customer",
                    imageheight: 36,
                    imagewidth: 38,
                    spaceheight: 3,
                    onTap: () {
                      context.push('/addcustomer');
                    },
                  ),
                  SizedBox(width: s(14)),
                  HomeMenuSection(
                    imagePath: "assets/images/dashboard/tickets.png",
                    title: "Buy Tickets",
                    imageheight: 30,
                    imagewidth: 30,
                    spaceheight: 9,
                    onTap: () {
                      context.push('/buy_ticket');
                    },
                  ),
                  SizedBox(width: s(14)),
                  HomeMenuSection(
                    imagePath: "assets/images/dashboard/home_dashboard.png",
                    title: "Dashboard",
                    imageheight: 36,
                    imagewidth: 36,
                    spaceheight: 3,
                    onTap: () {
                      context.push('/dashboard_chart');
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: s(30)),
            Text(
              "ABC Game",
              style: TextStyles.dmSans16SemiBold.copyWith(
                fontSize: s(16),
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: themedata.colorScheme.primary,
              ),
            ),
            SizedBox(height: s(12)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s(16)),
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
              style: TextStyles.dmSans16SemiBold.copyWith(
                fontSize: s(16),
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: themedata.colorScheme.primary,
              ),
            ),
            SizedBox(height: s(12)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s(16)),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: s(9),
                mainAxisSpacing: s(10),
                childAspectRatio: 1.0,
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
              style: TextStyles.dmSans16SemiBold.copyWith(
                fontSize: s(16),
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: themedata.colorScheme.primary,
              ),
            ),
            SizedBox(height: s(20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s(16)),
              child: const WhatsGbBox(),
            ),

            SizedBox(height: s(31)),
            Text(
              "Fantasy Sports",
              style: TextStyles.dmSans16SemiBold.copyWith(
                fontSize: s(16),
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: themedata.colorScheme.primary,
              ),
            ),
            SizedBox(height: s(6)),
            Text(
              "Build your team. Play smart. Win real rewards.",
              style: TextStyles.dmSans12.copyWith(
                fontSize: s(12),
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: themedata.textTheme.bodyLarge?.color,
              ),
            ),
            SizedBox(height: s(20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s(16)),
              child: DashboardFantasyScrollSection(),
            ),
            SizedBox(height: s(42)),
            Text(
              "Pure Luck - Instant results.",
              style: TextStyles.dmSans16SemiBold.copyWith(
                fontSize: s(16),
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: themedata.colorScheme.primary,
              ),
            ),
            SizedBox(height: s(6)),
            Text(
              "No strategy. Just spin and see",
              style: TextStyles.dmSans10.copyWith(
                fontSize: s(10),
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: themedata.textTheme.bodyLarge?.color,
              ),
            ),
            SizedBox(height: s(20)),
            DashboradPureluckySectionCard(),
            SizedBox(height: s(30)),
          ],
        ),
      ),
    );
  }
}
