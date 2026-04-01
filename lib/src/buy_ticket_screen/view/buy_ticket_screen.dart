import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/customer_dealer_section.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/customer_info_card.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/lottery_dropdown_widget.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/lottery_footer_bar.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/lottery_info_card.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/lottery_number_card.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/lottery_number_card_double.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/lottery_number_card_triple.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/search_field_widget.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/selected_lottery_number.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/time_slot_picker.dart';
import 'package:gb_lottery_b2b/src/common/widgets/appbar_widget.dart';
import 'package:go_router/go_router.dart';
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
  void _openMyNumbersBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 👈 CRITICAL: Allows custom heights taller than half-screen
      useSafeArea: true,
      backgroundColor: Colors.transparent, // 👈 Keep transparent to see your custom radius
      builder: (bottomSheetContext) {
        // Use Wrap or a Column with mainAxisSize.min to allow it to respect child height
        return MyNumberSummaryView(
          selectedNumbers: myItems,
          onClearAll: () {
            _handleClearAll();
            if (Navigator.canPop(bottomSheetContext)) Navigator.pop(bottomSheetContext);
          },
          onDeleteItem: (index) {
            _handleDeleteItem(index);
            if (myItems.isEmpty && Navigator.canPop(bottomSheetContext)) Navigator.pop(bottomSheetContext);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;
    final topPadding = MediaQuery.of(context).padding.top;
    final appBarHeight = s(60) + topPadding;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: AppbarWidget(s: s, title: "Buy Tickets", showBack: true),
      ),
      bottomNavigationBar: LotteryFooterBar(
        totalAmount: _totalPrice,
        totalNumbers: _totalCount,
        onToggle: () {
          if (myItems.isNotEmpty) {
            setState(() {
              isCartVisible = !isCartVisible;
            });
          }
        },
      ),
      bottomSheet: isCartVisible
          ? MyNumberSummaryView(
        selectedNumbers: myItems,
        onClearAll: () {
          _handleClearAll();
          setState(() {
            isCartVisible = false;
          });
        },
        onDeleteItem: (index) {
          _handleDeleteItem(index);

          if (myItems.isEmpty) {
            setState(() {
              isCartVisible = false;
            });
          }
        },
      )
          : null,
      backgroundColor: ColorPalette.background,
      body: SingleChildScrollView(
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
              // Inside Column in BuyTicketsScreen
              SearchFieldWidget(
                s: s,
                onTap: () {
                  // Replace 'searchCustomerScreen' with your actual route name
                  context.pushNamed("search_screen");
                },
              ),
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
              // Remove the SizedBox width or set it to double.infinity
              Container(
                width: double.infinity,
                height: s(135),
                decoration: BoxDecoration(
                  color: const Color(0xFF24232A), // Matches your card color
                  borderRadius: BorderRadius.circular(s(8)),
                ),
                child: Image.asset(
                  "assets/images/buy_ticket/kerala_lottery.webp",
                  fit: BoxFit.fill, // 🔥 FIX: Shows the entire image safely
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
              /*if (!isCartVisible) ...[
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
                      s:s,
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
              ],*/
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  LotteryNumberCard(
                    s: s,
                    onAdd: _handleAddition,
                  ),
                  const SizedBox(height: 16),
                  LotteryNumberCardDouble(
                    s: s,
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
              SizedBox(height: s(20),),
              LotteryNumberCardTriple(
                s: s,
                lotteryType: "Triple Digit",
                prize: "Win ₹20000.00",
                ticketPrice: "100.00",
                letters: const ["A", "B", "C"],
                // Update this signature to include count and price
                onAdd: (label, value, isBox, count, price) {
                  // Now you pass the actual 'count' and 'price' coming from the card
                  _handleAddition(
                    label,
                    value,
                    count,
                    price,
                  );
                },
              ),
              SizedBox(height: 76,),

            ],
          ),
        ),
      ),
    );
  }
}
