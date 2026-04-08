import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:gb_lottery_b2b/src/wallet_screen/view/widget/recent_transactions_section.dart';
import 'package:gb_lottery_b2b/src/wallet_screen/view/widget/wallet_card.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1116),
      appBar: AppBarTextWithBack(title: "Wallet"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(s(16)), // ✅ scaled padding
            child: Column(
              children: [
                const WalletScreenCard(),

                SizedBox(height: s(68)), // ✅ scaled gap

                const RecentTransactionsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}