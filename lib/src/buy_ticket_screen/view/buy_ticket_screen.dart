import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/app_theme.dart';
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
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';

import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';

import 'model/customer_model.dart';

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
  CustomerModel? selectedCustomer;
  String selectedLottery = "Kerala Lottery, ABC";

  final List<String> lotteryItems = [
    "Kerala Lottery, ABC",
    "Kerala Lottery, XYZ",
    "Kerala Lottery, DEF",
  ];

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
    final themedata = theme.context.of(context);
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBarTextWithBack(title: "Buy Ticket",),
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
      backgroundColor: themedata.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left:s(16),top:s(30),right:s(16),),
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
                onTap: () async {
                  final result = await context.pushNamed<CustomerModel>(
                    "search_screen",
                  );

                  if (result != null) {
                    setState(() {
                      selectedCustomer = result;
                    });
                  }
                },
              ),
              SizedBox(height: s(16),),
              if (selectedCustomer != null) ...[
                CustomerInfoCard(
                  s: s,
                  customer: selectedCustomer!,
                ),
                SizedBox(height: s(26)),
              ],
              SizedBox(
                width: s(128),   // ✅ correct width
                height: s(20),   // ✅ correct height
                child: Text(
                  "Select Lottery",
                  style: TextStyles.dmSans16SemiBold.copyWith(
                    color: themedata.textTheme.bodyLarge?.color,
                    fontSize: s(16),
                    fontStyle: FontStyle.italic,
                    height: 20 / 16,
                  ),
                ),
              ),
              SizedBox(height: s(10),),
              LotteryDropdownWidget(
                s: s,
                text: selectedLottery,
                items: lotteryItems,
                onSelected: (value) {
                  setState(() {
                    selectedLottery = value;
                  });
                },
              ),
              SizedBox(height: s(30),),
              // Remove the SizedBox width or set it to double.infinity
              Container(
                width: double.infinity,
                height: s(135),
                decoration: BoxDecoration(
                  color: themedata.cardColor, // Matches your card color
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
                  style: TextStyles.dmSans16SemiBold.copyWith(
                    color: themedata.textTheme.bodyLarge?.color,
                    fontSize: s(16),
                    fontStyle: FontStyle.italic,
                    height: 20 / 16,
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
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  LotteryNumberCard(
                    s: s,
                    onAdd: _handleAddition,
                  ),
                  const SizedBox(height: 27),
                  LotteryNumberCardDouble(
                    s: s,
                    lotteryType: "Double Digit",
                    prize: "Win ₹1000.00",
                    ticketPrice: "₹100.00",
                    onAdd: _handleAddition,
                    rows: const [
                      ["A", "B"],
                      ["A", "C"],
                      ["B", "C"],
                    ],
                  ),
                ],
              ),
              SizedBox(height: s(21),),
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

  void _showLotteryBottomSheet(
      BuildContext context,
      double Function(double) s,
      ) {
    final themedata = theme.context.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: themedata.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(s(16)),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(s(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: lotteryItems.map((item) {
              return ListTile(
                title: Text(
                  item,
                  style: TextStyles.dmSans14.copyWith(
                    color: themedata.textTheme.bodyLarge?.color,
                    fontSize: s(14),
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedLottery = item;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
