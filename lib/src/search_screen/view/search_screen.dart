import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/widgets/appbar_widget.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(s(60) + MediaQuery.of(context).padding.top),
        child: AppbarWidget(s: s, title: "Search", showBack: true),
      ),
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
                  // Background Color: #24232A
                  color: const Color(0xFF24232A),
                  borderRadius: BorderRadius.circular(s(10)),
                  // Border Color: #1F1E24
                  border: Border.all(
                    color: const Color(0xFF1F1E24),
                    width: 1.2,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: s(16)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Search customer by Name or Mobile...",
                        style: GoogleFonts.dmSans(
                          // Selection/Hint Color: #9F9F9F
                          color: const Color(0xFF9F9F9F),
                          fontSize: s(12),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          height: 1.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: s(17)),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return CustomerSearchCard(
                      s: s,
                      name: "Baranee A",
                      pincode: "642120",
                      phone: "9874563212",
                      initial: "B",
                      // Pass index to handle specific borders if needed
                      isFirst: index == 0,
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
