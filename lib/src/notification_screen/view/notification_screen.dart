import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/appbar_widget.dart';
import 'package:gb_lottery_b2b/src/notification_screen/view/widget/notification_card_item.dart';
import 'package:gb_lottery_b2b/src/notification_screen/view/widget/notification_filter_chips.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1116),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          s(60) + MediaQuery.of(context).padding.top,
        ),
        child: AppbarWidget(
          s: s,
          title: "Notification",
          showBack: true,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: s(11)),

            NotificationFilterChips(
              s: s,
              filters: const [
                "All",
                "General",
                "Critical",
                "Customer",
                "In-app",
              ],
              onChanged: (value) {
                setState(() {
                  selectedFilter = value;
                });
              },
            ),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(s(16)),
                itemCount: 1,
                separatorBuilder: (_, __) => SizedBox(height: s(12)),
                itemBuilder: (context, index) {
                  return NotificationCardItem(
                    s: s,
                    title: "Wallet Amount Credited",
                    message:
                    "Amount has been added to your wallet.\nYou can now continue purchase tickets without interruption.",
                    time: "1 day ago",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}