
import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/widgets/appbar_widget.dart';
import 'package:gb_lottery_b2b/src/myCart_Screen/view/widget/cart_item_card.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MycartScreen extends StatefulWidget {
  const MycartScreen({super.key});

  @override
  State<MycartScreen> createState() => _MycartScreenState();
}

class _MycartScreenState extends State<MycartScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(s(60) + MediaQuery.of(context).padding.top),
        child: AppbarWidget(s: s, title: "My Cart", showBack: true),
      ),
        backgroundColor: ColorPalette.background,

      /// --- 1. ONLY PAY NOW BUTTON IS FIXED ---
      bottomNavigationBar: Container(
        color: const Color(0xFF1C1B20),
        padding: EdgeInsets.fromLTRB(
            s(16),
            s(10),
            s(16),
            MediaQuery.of(context).padding.bottom + s(16)
        ),
        child: GestureDetector(
          onTap: () {
           //context.push("/profile");
          },
          child: Container(
            width: double.infinity,
            height: s(50),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFA89A5F), Color(0xFFDFC45C)],
              ),
              borderRadius: BorderRadius.circular(s(8)),
            ),
            child: Text(
              'Pay Now',
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontSize: s(16),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),

      /// --- 2. TOTAL AMOUNT BOX MOVED INSIDE SCROLL VIEW ---
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Your List of Cards
            ListView.builder(
              shrinkWrap: true, // Needed inside SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: s(16)),
              itemCount: 3,
              itemBuilder: (context, index) => CartItemCard(s: s),
            ),

            SizedBox(height: s(16)),

            // Total Amount Box (Now Scrolls)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s(16)),
              child: Container(
                width: double.infinity,
                // Figma height: 69
                height: s(69),
                decoration: BoxDecoration(
                  color:  ColorPalette.backgroundDark,
                  borderRadius: BorderRadius.circular(s(8)),
                ),
                // Using Padding to match Figma: 16 left/right, 25 top, 24 bottom
                padding: EdgeInsets.only(
                  left: s(16),
                  right: s(16),
                  top: s(25),
                  bottom: s(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Total Amount',
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: s(14),
                        fontWeight: FontWeight.w600,
                        height: 1.43, // From Figma 'height' property
                      ),
                    ),
                    Text(
                      '₹60',
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: s(14),
                        fontWeight: FontWeight.w600,
                        height: 1.43, // From Figma 'height' property
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Space below the Total Amount box before reaching the fixed button
            SizedBox(height: s(26)),
          ],
        ),
      ),
    );
  }
}
