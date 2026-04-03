import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreenCard extends StatelessWidget {
  const WalletScreenCard({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Column(
      children: [
        /// TOP CARD ONLY
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF24232A),
            borderRadius: BorderRadius.circular(s(10)),
          ),
          child: Padding(
            padding: EdgeInsets.only(top:s(29),left: s(19),bottom: s(15),right: s(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Money",
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(14),
                    fontWeight: FontWeight.w500,
                    height: 1, // removes extra font spacing
                  ),
                ),

                SizedBox(height: s(4)), // exact gap between label and amount

                Text(
                  "₹3,00,000",
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(40),
                    fontWeight: FontWeight.w700,
                    height: 1, // removes top and bottom extra space
                  ),
                ),

                SizedBox(height: s(18)),

                /// PROGRESS BAR
                ClipRRect(
                  borderRadius: BorderRadius.circular(s(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 35,
                        child: Container(height: s(12), color: Colors.green),
                      ),
                      Expanded(
                        flex: 25,
                        child: Container(height: s(12), color: Colors.orange),
                      ),
                      Expanded(
                        flex: 25,
                        child: Container(height: s(12), color: Colors.red),
                      ),
                      Expanded(
                        flex: 15,
                        child: Container(height: s(12), color: Colors.white),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: s(8)),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Aligns text baseline with bottom of card
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: s(4)), // Subtle alignment adjustment
                        child: Text(
                          "Your Money is too Low",
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: s(14),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none, // Allows the red dot to show outside the box
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: s(-4), // Exactly half of the height (8/2) peeks above the top border
                          right: s(46), // Adjust this value to align perfectly with your progress bar
                          child: Container(
                            width: s(8),
                            height: s(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF0000),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        /// THE GOLD BOX
                        Container(
                          width: s(104),
                          height: s(44),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
                            ),
                            borderRadius: BorderRadius.circular(s(8)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Spent Money",
                                style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontSize: s(10),
                                  fontWeight: FontWeight.w600,
                                  height: 1.0,
                                ),
                              ),
                              Text(
                                "₹2,62,580",
                                style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontSize: s(16),
                                  fontWeight: FontWeight.w700,
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// THE RED DOT (Half-in, half-out)

                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: s(20)),

        /// CHECKBOX OUTSIDE CARD
        Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Ensures vertical centering with text
          children: [
            Container(
              width: s(18),
              height: s(18),
              // Figma shows a corner radius of 2px
              decoration: BoxDecoration(
                color: const Color(0xFFDFC45C),
                borderRadius: BorderRadius.circular(s(2)),
              ),
              // Centering the asset directly inside the container
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/wallet/check_tick.webp",
                height: s(12),
                width: s(12),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: s(10)), // 10px spacing as per your requirement
            Expanded(
              child: Text(
                "I will send money within 2 days",
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: s(14),
                  fontWeight: FontWeight.w400, // Matching typical Figma body weight
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: s(17)),

        /// BUTTONS OUTSIDE CARD
        Row(
          children: [
            Expanded(
              child: _button(
                s,
                text: "Money Request",
                isGold: true,
                onTap: (){},
              ),
            ),
            SizedBox(width: s(16)),
            Expanded(
              child: _button(
                s,
                text: "Buy Tickets",
                isGold: false,
                onTap: () => context.push('/buy_ticket'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _button(
      double Function(double) s, {
        required String text,
        required bool isGold,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: s(48),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: isGold
              ? const LinearGradient(
            colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
          )
              : null,
          color: isGold ? null : const Color(0xFF313038),
          borderRadius: BorderRadius.circular(s(10)),
        ),
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontSize: s(14),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}