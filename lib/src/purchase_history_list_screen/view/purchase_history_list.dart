import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';

import 'package:gb_lottery_b2b/src/purchase_history_list_screen/view/widget/purchase_history_list_item.dart';
import 'package:gb_lottery_b2b/src/purchase_history_list_screen/view/widget/purchase_option_button.dart';
import 'package:go_router/go_router.dart';
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
      appBar: AppBarTextWithBack(title: "Purchase History"),
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
                padding: EdgeInsets.symmetric(horizontal: s(16)),
                child: Column(
                  children: [
                    SizedBox(height: s(19)),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
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
                                hintText:
                                    "Search customer by Name or Mobile...",
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
                        ),
                        SizedBox(width: s(12)),
                        GestureDetector(
                          onTapDown: (details) async {
                            final selected = await showMenu(
                              context: context,
                              color: const Color(0xFF313038),
                              position: RelativeRect.fromLTRB(
                                w - s(16 + 30),
                                details.globalPosition.dy,
                                s(40),
                                0,
                              ),
                              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(s(12)), ),
                              items: [
                                PopupMenuItem(
                                  value: "Upcoming",
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    height: s(42),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF313038),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(s(10)),
                                        topRight: Radius.circular(s(10)),
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: s(13)),
                                    child: Text(
                                      "Upcoming",
                                      style: GoogleFonts.dmSans(
                                        color: ColorPalette.whitetext,
                                        fontWeight: FontWeight.w400,
                                        fontSize: s(14),
                                      ),
                                    ),
                                  ),
                                ),

                                // 🔸 DIVIDER
                                PopupMenuItem(
                                  enabled: false,
                                  padding: EdgeInsets.zero,
                                  height: s(1),
                                  child: Divider(
                                    height: 1,
                                    thickness: 0.5,
                                    color: ColorPalette.darktext.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                ),

                                PopupMenuItem(
                                  value: "Completed",
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: s(132),
                                    height: s(42),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF313038),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(s(10)),
                                        bottomRight: Radius.circular(s(10)),
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: s(13)),
                                    child: Text(
                                      "Completed",
                                      style: GoogleFonts.dmSans(
                                        color: ColorPalette.whitetext,
                                        fontWeight: FontWeight.w400,
                                        fontSize: s(14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );

                            // 🔥 Handle selection
                            if (selected == "Upcoming") {
                              print("Upcoming clicked");
                            } else if (selected == "Completed") {
                              print("Completed clicked");
                            }
                          },

                          child: Container(
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
                        ),
                      ],
                    ),
                    SizedBox(height: s(20)),
                    PurchaseOptionButton(),
                  ],
                ),
              ),

              SizedBox(height: s(20)),
              ListView.separated(
                padding: EdgeInsets.zero, // Ensure no internal list padding
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (_, __) => SizedBox(height: s(4)),
                itemBuilder: (context, index) {
                  // If you need the items to touch the screen edges,
                  // ensure the 'PurchaseHistoryListItem' width is set to 'double.infinity' or 'w'
                  return GestureDetector(
                    onTap: () => context.push('/purchase_history_details'),
                    child: PurchaseHistoryListItem(s: s),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
