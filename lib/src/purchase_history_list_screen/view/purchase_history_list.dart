import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/appbar_widget.dart';
import 'package:gb_lottery_b2b/src/purchase_history_list_screen/view/widget/purchase_history_list_item.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseHistoryList extends StatefulWidget {
  const PurchaseHistoryList({super.key});

  @override
  State<PurchaseHistoryList> createState() => _PurchaseHistoryListState();
}

class _PurchaseHistoryListState extends State<PurchaseHistoryList> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          s(60) + MediaQuery.of(context).padding.top,
        ),
        child: AppbarWidget(s: s, title: "Purchase History", showBack: true),
      ),
      backgroundColor: const Color(0xFF0F1116),
      body: SafeArea(
        top: false, // appbar already handles top
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Wrap ONLY the top section (Search/Filter) in Padding
              Padding(
                padding: EdgeInsets.all(s(16),),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: s(48),
                            padding: EdgeInsets.symmetric(horizontal: s(16)),
                            decoration: BoxDecoration(
                              color: const Color(0xFF24232A),
                              borderRadius: BorderRadius.circular(s(10)),
                              border: Border.all(
                                color: const Color(0xFF1F1E24),
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Search customer by Name or Mobile...",
                              style: GoogleFonts.dmSans(
                                color: const Color(0xFF9F9F9F),
                                fontSize: s(12),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: s(12)),
                        Container(
                          width: s(54),
                          height: s(48),
                          decoration: BoxDecoration(
                            color: const Color(0xFF24232A),
                            borderRadius: BorderRadius.circular(s(10)),
                            border: Border.all(
                              color: const Color(0xFF1F1E24),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/purchase_history_list/filter_icon.webp",
                              width: s(20),
                              height: s(20),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),



              // 2. ListView now has NO horizontal padding
              ListView.separated(
                padding: EdgeInsets.zero, // Ensure no internal list padding
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (_, __) => SizedBox(height: s(4)),
                itemBuilder: (context, index) {
                  // If you need the items to touch the screen edges,
                  // ensure the 'PurchaseHistoryListItem' width is set to 'double.infinity' or 'w'
                  return PurchaseHistoryListItem(s: s);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
