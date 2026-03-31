import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/customer_dealer_section.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/customer_info_card.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/lottery_dropdown_widget.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/lottery_info_card.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/lottery_number_card.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/lottery_number_card_double.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/search_field_widget.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/selected_lottery_number.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/time_slot_picker.dart';
import 'package:gb_lottery_b2b/src/common/widgets/appbar_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyTicketsScreen extends StatefulWidget {
  const BuyTicketsScreen({super.key});

  @override
  State<BuyTicketsScreen> createState() => _BuyTicketsScreenState();
}

class _BuyTicketsScreenState extends State<BuyTicketsScreen> {
  String selectedType = "Customer";
  String selectedTime = "02:00 PM";
  double _totalPrice = 0.0;
  int _totalCount = 0;
  bool isCartVisible = false;
  List<SelectedLotteryNumber> myItems = [];

  void _handleAddition(
      String letter,
      String value,
      int qty,
      double pricePerUnit,
      ) {
    setState(() {
      _totalCount += qty;
      _totalPrice += (pricePerUnit * qty);

      myItems.add(
        SelectedLotteryNumber(
          label: "$letter=$value",
          price: "₹${pricePerUnit.toStringAsFixed(1)}",
          quantity: qty,
        ),
      );
    });
  }

  void _handleClearAll() {
    setState(() {
      _totalPrice = 0.0;
      _totalCount = 0;
      myItems.clear();
      // Auto-switch back to game view when cart is cleared
      isCartVisible = false;
    });
  }

  void _handleDeleteItem(int index) {
    setState(() {
      final item = myItems[index];
      double unitPrice = double.tryParse(item.price.replaceAll('₹', '')) ?? 0.0;

      _totalCount -= item.quantity;
      _totalPrice -= (unitPrice * item.quantity);
      myItems.removeAt(index);

      // Auto-switch back to game view if the last item was deleted
      if (myItems.isEmpty) {
        isCartVisible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;
    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: Column(
        children: [
          /// 🔷 APP BAR
          AppbarWidget(s: s, title: "Buy Tickets", showBack: true),

          /// 🔽 SCROLL AREA
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(s(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomerDealerSection(
                      s: s,
                      selectedType: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                        });
                      },
                    ),
                    SizedBox(height: s(29),),
                    SearchFieldWidget(s: s),
                    SizedBox(height: s(16),),
                    CustomerInfoCard(s: s),
                    SizedBox(height: s(26),),
                    SizedBox(
                      width: s(128),   // ✅ correct width
                      height: s(20),   // ✅ correct height
                      child: Text(
                        "Select Lottery",
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: s(16),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          height: 20 / 16, // ✅ line height
                        ),
                      ),
                    ),
                    SizedBox(height: s(10),),
                    LotteryDropdownWidget(s: s, text: "Kerala Lottery , ABC",
                      onTap: () {
                        // open dropdown
                      },
                    ),
                    SizedBox(height: s(30),),
                    Padding(
                      padding: EdgeInsets.only(left: s(2)), // 16 (parent) + 2 = 18 total
                      child: Container(
                        width: double.infinity,
                        height: s(135),
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/images/buy_ticket/kerala_lottery.webp"),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(s(8)),
                              bottomLeft: Radius.circular(s(8)),
                              // We don't need a radius on the right if it's hitting the screen edge,
                              // but if you want it rounded, keep circular(s(8))
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: s(30),),
                    SizedBox(
                      width: s(130),   // ✅ correct width
                      height: s(22),   // ✅ correct height
                      child: Text(
                        "Select Time Slot",
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: s(16),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          height: 20 / 16, // ✅ line height
                        ),
                      ),
                    ),
                    SizedBox(height: s(10),),
                    TimeSlotPicker(
                      s: s,
                      slots: const [
                        "02:00 PM",
                        "03:00 PM",
                        "05:00 PM",
                        "10:00 AM",
                        "11:00 AM",
                      ],
                      onSelectionChanged: (time) {
                        setState(() {
                          selectedTime = time;
                        });
                      },
                    ),
                    SizedBox(height: s(13),),
                    LotteryInfoCard(s: s),
                    SizedBox(height: s(14),),
                    if (!isCartVisible) ...[
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        children: [
                          LotteryNumberCard(s: s,onAdd: _handleAddition),
                          const SizedBox(height: 16),
                          LotteryNumberCardDouble(
                            lotteryType: "Double Digit",
                            prize: "Win ₹1000.00",
                            ticketPrice: "₹100",
                            onAdd: _handleAddition,
                            rows: const [
                              ["A", "B"],
                              ["A", "C"],
                              ["B", "C"],
                            ],
                          ),
                        ],
                      ),
                    ] else ...[
                      MyNumberSummaryView(
                        selectedNumbers: myItems,
                        onClearAll: _handleClearAll,
                        onDeleteItem: _handleDeleteItem,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
