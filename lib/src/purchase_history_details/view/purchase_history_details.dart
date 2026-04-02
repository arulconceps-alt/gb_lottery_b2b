
import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/appbar_widget.dart';
import 'package:gb_lottery_b2b/src/purchase_history_details/view/widgets/purchase_history_item_card.dart';


class PurchaseHistoryDetails extends StatefulWidget {
  const PurchaseHistoryDetails({super.key});

  @override
  State<PurchaseHistoryDetails> createState() => _PurchaseHistoryDetailsState();
}

class _PurchaseHistoryDetailsState extends State<PurchaseHistoryDetails> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(s(60) + MediaQuery.of(context).padding.top),
        child: AppbarWidget(s: s, title: "Purchase History", showBack: true),
      ),
      backgroundColor: const Color(0xFF0F1116),
      body: SafeArea(
        top: false, // appbar already handles top
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: s(16)),
                itemCount: 3,
                itemBuilder: (context, index) => PurchaseHistoryItemCard(s: s),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
