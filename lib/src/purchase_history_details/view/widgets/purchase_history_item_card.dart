import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseHistoryItemCard extends StatefulWidget {
  final double Function(double) s;

  const PurchaseHistoryItemCard({super.key, required this.s});

  @override
  State<PurchaseHistoryItemCard> createState() => _PurchaseHistoryItemCardState();
}

class _PurchaseHistoryItemCardState extends State<PurchaseHistoryItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: widget.s(16), bottom: widget.s(16)),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(widget.s(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// --- 1. Image Section ---
                Container(
                  width: widget.s(56),
                  height: widget.s(44),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.s(8)),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/myCart/list_image.webp"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: widget.s(14)),
    
                /// --- 2. Info Section ---
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kerala Lottery , ABC',
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: widget.s(16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: widget.s(8)),
                      _infoText("Customer name : ", "Baranee"),
                      _infoText("Phone number : ", "9874563215"),
                      _infoText("Customer Id  : ", "56526"),
                      _infoText("Pincode  : ", "642120"),
                      SizedBox(height: widget.s(12)),
    
                      /// Numbers Row
                      Wrap(
                        spacing: widget.s(8),
                        runSpacing: widget.s(8),
                        children: [
                          _numberBadge("A=1", "₹10.0", "x1"),
                          _numberBadge("B=1", "₹10.0", "x1"),
                          _numberBadge("C=1", "₹10.0", "x1"),
                        ],
                      ),
                      SizedBox(height: widget.s(12)),
                      _infoText("Total Price : ", "₹30", isTotal: true),
                    ],
                  ),
                ),
    
                /// --- 3. Right Side Badges ---
                Column(
                  children: [
                    _sideBadge("Digits", "1"),
                    SizedBox(height: widget.s(8)),
                    _sideBadge("Drawn Time", "02:00 PM", isTime: true),
                  ],
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
      padding: EdgeInsets.only(bottom: widget.s(2)),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: label,
              style: GoogleFonts.dmSans(
                color: const Color(0xFF9F9F9F),
                fontSize: widget.s(isTotal ? 14 : 10),
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: value,
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontSize: widget.s(isTotal ? 14 : 10),
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
      padding: EdgeInsets.symmetric(horizontal: widget.s(6), vertical: widget.s(4)),
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(widget.s(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: GoogleFonts.dmSans(color: Colors.white, fontSize: widget.s(10), fontWeight: FontWeight.w600)),
          SizedBox(width: widget.s(4)),
          Text(price, style: GoogleFonts.dmSans(color: Colors.white, fontSize: widget.s(8))),
          SizedBox(width: widget.s(4)),
          Container(
            padding: EdgeInsets.all(widget.s(1)),
            decoration: BoxDecoration(color: const Color(0xFFCDB75D), borderRadius: BorderRadius.circular(2)),
            child: Text(qty, style: GoogleFonts.dmSans(color: Colors.black, fontSize: widget.s(6), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _sideBadge(String label, String value, {bool isTime = false}) {
    return Container(
      // Matches Figma dimensions
      width: widget.s(80),
      height: widget.s(40),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(widget.s(6)),
      ),
      child: isTime
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.dmSans(
              color: const Color(0xFF9F9F9F),
              fontSize: widget.s(8),
              fontWeight: FontWeight.w400,
              letterSpacing: -0.08,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: widget.s(8),
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
              fontSize: widget.s(12),
              fontWeight: FontWeight.w500,
              letterSpacing: -0.12,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: widget.s(12),
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
          padding: EdgeInsets.symmetric(vertical: widget.s(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: widget.s(18),
                height: widget.s(18),
                fit: BoxFit.contain,
              ),
              SizedBox(width: widget.s(8)),
              Text(
                label,
                style: GoogleFonts.dmSans(
                  color: const Color(0xFF9F9F9F).withOpacity(0.6),
                  fontSize: widget.s(14),
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
