import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:gb_lottery_b2b/src/common/widgets/custom_drawer.dart';
import 'package:gb_lottery_b2b/src/dashboard_chart_screen/view/widgets/customer_growth_card.dart';
import 'package:gb_lottery_b2b/src/dashboard_chart_screen/view/widgets/purchase_chart_card.dart' show PurchaseChartCard;
import 'package:gb_lottery_b2b/src/dashboard_chart_screen/view/widgets/revenue_chart_card.dart';
import 'package:gb_lottery_b2b/src/dashboard_chart_screen/view/widgets/top5_customers_chart.dart';



class DashboardChartScreen extends StatefulWidget {
  const DashboardChartScreen({super.key});

  @override
  State<DashboardChartScreen> createState() => _DashboardChartScreenState();
}

class _DashboardChartScreenState extends State<DashboardChartScreen> {

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B20),
      drawer: const CustomDrawer(),
      appBar: AppBarTextWithBack(title: "Dashboard",),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: s(16)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: s(21)),
              PurchaseChartCard(s:s),
              SizedBox(height: s(20)),
              CustomerGrowthCard(),
              SizedBox(height: 16,),
              RevenueChartCard(),
              SizedBox(height: s(20),),
              Top5CustomersChart(s:s),
              SizedBox(height: s(82),),
            ],
          ),
        ),
      ),
    );
  }
}
