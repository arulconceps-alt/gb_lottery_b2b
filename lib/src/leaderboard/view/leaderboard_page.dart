import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:gb_lottery_b2b/src/leaderboard/view/widgets/leaderboard_container.dart';
import 'package:gb_lottery_b2b/src/leaderboard/view/widgets/leaderboard_list_section.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1B20),
      appBar: AppBarTextWithBack(title: "LeaderBoard"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: s(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: s(18)),
             LeaderboardContainer(),
              SizedBox(height: s(25)),  
              LeaderboardListSection(),
            ],  
          ),
        ),
      ),
    );
  }
}
