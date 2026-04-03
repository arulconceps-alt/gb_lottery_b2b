import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:gb_lottery_b2b/src/settlement/view/widgets/settlement_commision_card.dart';
import 'package:gb_lottery_b2b/src/settlement/view/widgets/settlement_monthly_card.dart';
import 'package:gb_lottery_b2b/src/settlement/view/widgets/settlement_top_section.dart';
import 'package:gb_lottery_b2b/src/settlement/view/widgets/settlement_total_earning_card.dart';

class SettlementPage extends StatefulWidget {
  const SettlementPage({super.key});

  @override
  State<SettlementPage> createState() => _SettlementPageState();
}

class _SettlementPageState extends State<SettlementPage> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B20),
      appBar: AppBarTextWithBack(title: "Settlement"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: s(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: s(27)),
              SettlementTopSection(
                items: [
                  {
                    "icon": "assets/images/settlement/total_sales.webp",
                    "text1": "Total Sales",
                    "text2": "₹2,45,000",
                    "text3": "This Month",
                  },
                  {
                    "icon": "assets/images/settlement/settlement_earned.webp",
                    "text1": "Commission Rate",
                    "text2": "15%",
                    "text3": "On all sales",
                  },
                  {
                    "icon": "assets/images/settlement/commission_rate.webp",
                    "text1": "Settlement Earned",
                    "text2": "₹35,420",
                    "text3": "this month",
                  },
                  {
                    "icon": "assets/images/settlement/bonus.webp",
                    "text1": "Bonus",
                    "text2": "2000",
                    "text3": "Performance bonus",
                  },
                ],
              ),
              SizedBox(height: s(16)),
              SettlementTotalEarningCard(
                text1: "Total Earnings (This Month)",
                text2: "₹37,420",
                text3: "Settlement + Bonus",
                imagePath: "assets/images/settlement/dollar.webp",
              ),
              SizedBox(height: s(16)),
              SettlementMonthlyCard(),
              SizedBox(height: s(16)),
              SettlementCommissionCard(),
              SizedBox(height: s(40)),
            ],
          ),
        ),
      ),
    );
  }
}
