import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/app_theme.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';
import 'package:gb_lottery_b2b/src/common/widgets/common_app_bar.dart';
import 'package:gb_lottery_b2b/src/common/widgets/custom_drawer.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/dashboard_carousel.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/dashboard_fantasy_scroll_section.dart';
import 'package:gb_lottery_b2b/src/lottery/view/widgets/lottery_card.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/dashboard_top_section.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/home_menu_section.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/dashboard_pure_lucky_section.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/widgets/whats_gb_box.dart';
import 'package:gb_lottery_b2b/src/common/widgets/common_error_widget.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/common/services/services_locator.dart';
import 'package:gb_lottery_b2b/src/lottery/bloc/lottery_bloc.dart';

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

    return BlocProvider(
      create: (context) => getIt<LotteryBloc>()..add(FetchLotteries()),
      child: Scaffold(
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
              BlocBuilder<LotteryBloc, LotteryState>(
                builder: (context, state) {
                  if (state.status == LotteryStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == LotteryStatus.success) {
                    final regularLotteries = state.lotteries
                        .where((l) => l.type == 'REGULAR')
                        .toList();
                    final specialLotteries = state.lotteries
                        .where((l) => l.type == 'SPECIAL')
                        .toList();

                    return Column(
                      children: [
                        if (regularLotteries.isNotEmpty) ...[
                          Text(
                            "REGULAR LOTTERY",
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
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: s(9),
                                    mainAxisSpacing: s(10),
                                    childAspectRatio: 1.0,
                                  ),
                              itemCount: regularLotteries.length,
                              itemBuilder: (context, index) {
                                return LotteryCard(
                                  lottery: regularLotteries[index],
                                );
                              },
                            ),
                          ),
                        ],
                        SizedBox(height: s(33)),
                        if (specialLotteries.isNotEmpty) ...[
                          Text(
                            "SPECIAL LOTTERY",
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
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: s(9),
                                    mainAxisSpacing: s(10),
                                    childAspectRatio: 1.0,
                                  ),
                              itemCount: specialLotteries.length,
                              itemBuilder: (context, index) {
                                return LotteryCard(
                                  lottery: specialLotteries[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    );
                  } else if (state.status == LotteryStatus.failure) {
                    return CommonErrorWidget(
                      message: state.message,
                      onRetry: () {
                        context.read<LotteryBloc>().add(FetchLotteries());
                      },
                    );
                  }
                  return const SizedBox();
                },
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
              DashboardPureLuckySection(),
              SizedBox(height: s(30)),
            ],
          ),
        ),
      ),
    );
  }
}
