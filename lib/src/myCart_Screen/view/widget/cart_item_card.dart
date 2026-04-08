import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemCard extends StatelessWidget {
  final double Function(double) s;

  const CartItemCard({super.key, required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: s(16), bottom: s(8)),
      decoration: BoxDecoration(color: const Color(0xFF24232A)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(s(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// --- 1. Image Section ---
                Container(
                  width: s(56),
                  height: s(44),
                  decoration: BoxDecoration(
                    // Figma: Radius 8px
                    borderRadius: BorderRadius.circular(s(8)),
                    color: const Color(0xFFDFC45C),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/myCart/list_image.webp"),
                      fit: BoxFit
                          .cover, // Ensures the image fills the 56x44 area without gaps
                    ),
                  ),
                ),
                SizedBox(width: s(14)),

                /// --- 2. Info Section ---
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kerala Lottery , ABC',
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: s(16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: s(8)),
                      _infoText("Customer name : ", "Baranee"),
                      _infoText("Phone number : ", "9874563215"),
                      _infoText("Customer Id  : ", "56526"),
                      _infoText("Pincode  : ", "642120"),
                    ],
                  ),
                ),

                Column(
                  children: [
                    _sideBadge("Digits", "1"),
                    SizedBox(height: s(8)),
                    _sideBadge("Drawn Time", "02:00 PM", isTime: true),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _numberBadge("A=1", "₹10.0", "x1"),
                    SizedBox(width: s(8)),
                    _numberBadge("B=1", "₹10.0", "x1"),
                    SizedBox(width: s(8)),
                    _numberBadge("C=1", "₹10.0", "x1"),
                  ],
                ),
              ),
          
              SizedBox(height: s(13)),
          
              /// Total Price
              _infoText("Total Price : ", "₹30", isTotal: true),
            ]
          ),
           SizedBox(height: s(24)),
                /// --- 4. Bottom Action Bar ---
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                  ),
                  child: Row(
                    children: [
                      _actionButton(
                        "assets/images/myCart/edit_icon.webp",
                        "Edit",
                      ),
                      Container(
                        width: 1,
                        height: s(40),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      _actionButton(
                        "assets/images/myCart/delete_icon.webp",
                        "Remove",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget _infoText(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: s(2)),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: label,
              style: GoogleFonts.dmSans(
                color: const Color(0xFF9F9F9F),
                fontSize: s(isTotal ? 14 : 10),
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: value,
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontSize: s(isTotal ? 14 : 10),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _numberBadge(String label, String price, String qty) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: s(6), vertical: s(4)),
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(s(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: s(10),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: s(4)),
          Text(
            price,
            style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(8)),
          ),
          SizedBox(width: s(4)),
          Container(
            padding: EdgeInsets.all(s(1)),
            decoration: BoxDecoration(
              color: const Color(0xFFCDB75D),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              qty,
              style: GoogleFonts.dmSans(
                color: Colors.black,
                fontSize: s(6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sideBadge(String label, String value, {bool isTime = false}) {
    return Container(
      // Matches Figma dimensions
      width: s(80),
      height: s(40),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(s(6)),
      ),
      child: isTime
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFF9F9F9F),
                    fontSize: s(8),
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.08,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(8),
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.08,
                  ),
                ),
              ],
            )
          : Row(
              // This ensures "Digits : 1" stays on one line
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$label : ',
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFF9F9F9F),
                    fontSize: s(12),
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.12,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(12),
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.12,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _actionButton(String imagePath, String label) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: s(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: s(18),
                height: s(18),
                fit: BoxFit.contain,
              ),
              SizedBox(width: s(8)),
              Text(
                label,
                style: GoogleFonts.dmSans(
                  color: const Color(0xFF9F9F9F).withOpacity(0.6),
                  fontSize: s(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
