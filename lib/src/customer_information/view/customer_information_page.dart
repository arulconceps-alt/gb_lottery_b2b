import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:gb_lottery_b2b/src/customer_information/view/widgets/customer_info_card.dart';
import 'package:gb_lottery_b2b/src/customer_information/view/widgets/customer_top_card.dart';

class CustomerInformationPage extends StatefulWidget {
  const CustomerInformationPage({super.key});

  @override
  State<CustomerInformationPage> createState() =>
      _CustomerInformationPageState();
}

class _CustomerInformationPageState extends State<CustomerInformationPage> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    return Scaffold(
      backgroundColor: const Color(0xFF1F1E26),
      appBar: AppBarTextWithBack(title: "Customer Info"),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: s(16)),
          child: Column(
            children: [
              SizedBox(height: s(23)),
              CustomerTopCard(
                topTitle: "Winnings",
                topValue: "₹1,37,420",
                topGradient: const LinearGradient(
                  colors: [Color(0x4D20CE09), Color(0x8020CE09)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          
                bottomTitle: "Total Spent",
                bottomValue: "₹21,420",
                bottomGradient: ColorPalette.buttonGradient,
              ),
              SizedBox(height: s(12)),
              CustomerInfoCard(
                data: {
                  "Name": "Bala S",
                  "Phone": "98745 63215",
                  "Customer ID": "GB-C001",
                  "Email": "bala@gmail.com",
                  "Pincode": "642108",
                  "Address": "40 Ganapathy, Coimbatore",
                  "Join Date": "15/01/2026",
                  "Ticket Purchase": "150",
                  "Total Spent Money": "₹37,420",
                  "Total Winning Money": "₹1,37,420",
                },
              ),
               SizedBox(height: s(46)),
            ],
          ),
        ),
      ),
    );
  }
}
