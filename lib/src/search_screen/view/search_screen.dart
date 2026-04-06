import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/model/customer_model.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';

import 'package:gb_lottery_b2b/src/search_screen/view/widget/customer_search_card.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1116),
      appBar: AppBarTextWithBack( title: "Search",),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: s(16)), // Sets left & right to 16
          child: Column(
            children: [
              SizedBox(height: s(17)),
              Container(
                width: double.infinity,
                height: s(48),
                decoration: BoxDecoration(
                  color: const Color(0xFF24232A),
                  borderRadius: BorderRadius.circular(s(10)),
                  border: Border.all(
                    color: const Color(0xFF1F1E24),
                    width: 1.2,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: s(16)),
                alignment: Alignment.center,
                child: TextField(
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(12),
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search customer by Name or Mobile...",
                    hintStyle: GoogleFonts.dmSans(
                      color: const Color(0xFF9F9F9F),
                      fontSize: s(12),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                ),
              ),
              SizedBox(height: s(17)),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                          CustomerModel(
                            name: "Baranee A",
                            phone: "9874563212",
                            id: "56526",
                            pincode: "642120",
                          ),
                        );
                      },
                      child: CustomerSearchCard(
                        s: s,
                        name: "Baranee A",
                        phone: "9874563212",
                        id: "56526",
                        pincode: "642120",
                        initial: "B",
                        isFirst: index == 0,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
