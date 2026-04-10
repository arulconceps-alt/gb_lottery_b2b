import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/models/customer_model.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:gb_lottery_b2b/src/customer_information/view/widgets/customer_info_card.dart';
import 'package:gb_lottery_b2b/src/customer_information/view/widgets/customer_top_card.dart';

class CustomerInformationPage extends StatefulWidget {
  final CustomerModel customer;

  const CustomerInformationPage({super.key, required this.customer});

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
    final customer = widget.customer;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1B20),
      appBar: const AppBarTextWithBack(title: "Customer Info"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: s(16)),
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
                  "Name": customer.name,
                  "Phone": customer.phone,
                  "Customer ID": customer.id,
                  "Email": customer.email ?? "N/A",
                  "Pincode": customer.pincode,
                  "Address": customer.address ?? "N/A",
                  "Join Date": "15/01/2026", // Mock or from extra fields if needed
                  "Ticket Purchase": "150",   // Mock
                  "Total Spent Money": "₹37,420", // Mock
                  "Total Winning Money": "₹1,37,420", // Mock
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
