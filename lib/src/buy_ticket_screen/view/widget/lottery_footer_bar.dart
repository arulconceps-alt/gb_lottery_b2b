import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
// Import your route names file
// import 'package:gb_lottery/src/core/routing/route_names.dart';

class LotteryFooterBar extends StatelessWidget {
  final double totalAmount;
  final int totalNumbers;
  final VoidCallback onToggle;

  const LotteryFooterBar({
    super.key,
    required this.totalAmount,
    required this.totalNumbers,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1C1B20),
        border: Border(top: BorderSide(width: 2, color: Color(0xFF24232A))),
      ),
      child: SafeArea(
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // CLICKABLE AREA (Amount + Numbers)
              GestureDetector(
                onTap: onToggle,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Image.asset("assets/images/icons/leadingicon.webp"),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(

                          '₹${totalAmount.toStringAsFixed(2)}',

                          style: GoogleFonts.dmSans(

                            color: Colors.white,

                            fontSize: 28,

                            fontWeight: FontWeight.w500,

                            height: 1.30,

                            letterSpacing: -0.28,

                          ),

                        ),

                        Text(

                          '$totalNumbers numbers',

                          style: GoogleFonts.dmSans(

                            color: const Color(0xFF9F9F9F),

                            fontSize: 12,

                            fontWeight: FontWeight.w500,

                            height: 1.30,

                            letterSpacing: -0.12,

                          ),

                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // PAY NOW BUTTON WITH NAVIGATION
              GestureDetector(
                onTap: () {
                  // Add your navigation or cart logic here
                  context.pushNamed("myCart");
                },
                child: Container(
                  // 1. Fixed Figma Dimensions
                  width: 136,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    // 2. Corrected Gradient to match Figma [Left to Right]
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFA89A5F), // Darker gold
                        Color(0xFFDFC45C), // Lighter gold
                      ],
                    ),
                    // 3. Radius set to 10 for a rounded rectangle (not an oval)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.30,
                      letterSpacing: -0.18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
