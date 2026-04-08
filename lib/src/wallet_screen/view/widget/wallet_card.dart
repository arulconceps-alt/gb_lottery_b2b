import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreenCard extends StatefulWidget {
  const WalletScreenCard({super.key});

  @override
  State<WalletScreenCard> createState() => _WalletScreenCardState();
}

class _WalletScreenCardState extends State<WalletScreenCard> {
  bool isChecked = true;
  final double totalMoney = 300000;
  double ratio = 0.75;
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
                SizedBox(height: s(9)),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double fullWidth = constraints.maxWidth;
                    double cardWidth = s(104);

                    double leftPosition = (fullWidth * ratio) - (cardWidth / 2);
                    leftPosition = leftPosition.clamp(0.0, fullWidth - cardWidth);

                    double spentMoney = totalMoney * ratio;

                    bool showLowText = ratio >= 0.60;

                    List<Color> gradient;
                    if (ratio <= 0.35) {
                      gradient = [Colors.green, Colors.green.shade700];
                    } else if (ratio <= 0.60) {
                      gradient = [const Color(0xFFDFC45C), const Color(0xFFA89A5F)];
                    } else if (ratio <= 0.85) {
                      gradient = [Colors.red, Colors.red.shade700];
                    } else {
                      gradient = [Colors.grey, Colors.white54];
                    }

                    return GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          ratio += details.delta.dx / fullWidth;
                          ratio = ratio.clamp(0.0, 1.0);
                        });
                      },
                      child: SizedBox(
                        height: s(70),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            if (showLowText)
                              Positioned(
                                left: 0,
                                top: s(0),
                                child: Text(
                                  "Your Money is too Low",
                                  style: GoogleFonts.dmSans(
                                    color: Colors.white,
                                    fontSize: s(14),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),

                            /// Moving card
                            Positioned(
                              left: leftPosition,
                              top: s(0),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  /// Half outside top dot
                                  Positioned(
                                    top: s(-4),
                                    left: (cardWidth / 2) - s(4),
                                    child: Container(
                                      width: s(8),
                                      height: s(8),
                                      decoration: BoxDecoration(
                                        color: gradient.first,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),

                                  /// Moving money box
                                  Container(
                                    width: cardWidth,
                                    height: s(44),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: gradient,
                                      ),
                                      borderRadius: BorderRadius.circular(s(8)),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: s(19),
                                          top: s(5),
                                          child: SizedBox(
                                            width: s(67),
                                            height: s(14),
                                            child: Text(
                                              "Spent Money",
                                              style: GoogleFonts.dmSans(
                                                color: Colors.white,
                                                fontSize: s(10),
                                                fontWeight: FontWeight.w600,
                                                height: 1.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: s(15),
                                          top: s(19),
                                          child: SizedBox(
                                            width: s(80),
                                            height: s(20),
                                            child: Text(
                                              "₹${spentMoney.toStringAsFixed(0)}",
                                              style: GoogleFonts.dmSans(
                                                color: Colors.white,
                                                fontSize: s(16),
                                                fontWeight: FontWeight.w700,
                                                height: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: s(20)),

        /// CHECKBOX OUTSIDE CARD
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: s(18),
                height: s(18),
                child: Stack(
                  children: [
                    /// checkbox bg
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: s(18),
                        height: s(18),
                        decoration: ShapeDecoration(
                          color: isChecked
                              ? const Color(0xFFDFC45C)
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(s(2)),
                            side: const BorderSide(
                              color: Color(0xFFDFC45C),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// tick icon exact Figma position
                    if (isChecked)
                      Positioned(
                        left: s(3),
                        top: s(3),
                        child: Image.asset(
                          "assets/images/wallet/check_tick.webp",
                          width: s(12),
                          height: s(12),
                          fit: BoxFit.contain,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: s(10)),
              Expanded(
                child: Text(
                  "I will send money within 2 days",
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(14),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: s(17)),

        /// BUTTONS OUTSIDE CARD
        Row(
          children: [
            Expanded(
              child: _button(
                s,
                text: "Credit Request",
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