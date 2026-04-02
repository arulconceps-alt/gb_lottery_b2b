import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/common_app_bar.dart';
import 'package:gb_lottery_b2b/src/common/widgets/custom_drawer.dart';
import 'package:gb_lottery_b2b/src/results/view/widgets/resluts_lottry_section_card.dart';
import 'package:gb_lottery_b2b/src/results/view/widgets/resluts_top_tabs.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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
          padding:  EdgeInsets.symmetric(horizontal: s(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: s(20)),
              ResultsTopTabs(),
              SizedBox(height: s(20)),
              LotterySectionCard(title: "Kerala Lottry"),
              SizedBox(height: s(18)),
              LotterySectionCard(title: "Arunachal Pradesh"),
            ],
          ),
        ),
      )
    );
  }
}