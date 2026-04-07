import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseHistoryItemCard extends StatefulWidget {
  final double Function(double) s;

  const PurchaseHistoryItemCard({super.key, required this.s});

  @override
  State<PurchaseHistoryItemCard> createState() =>
      _PurchaseHistoryItemCardState();
}

class _PurchaseHistoryItemCardState
    extends State<PurchaseHistoryItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: widget.s(16), bottom: widget.s(16)),
       padding: EdgeInsets.all(widget.s(16)),
      decoration: const BoxDecoration(color: Color(0xFF24232A)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🔹 TOP SECTION (Row)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              Container(
                width: widget.s(56),
                height: widget.s(44),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.s(8)),
                  image: const DecorationImage(
                    image: AssetImage(
                        "assets/images/myCart/list_image.webp"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: widget.s(14)),
          
              /// Info Section
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
                  ],
                ),
              ),
          
              SizedBox(width: widget.s(8)),
          
              /// Side Badges
              Column(
                children: [
                  _sideBadge("Digits", "1"),
                  SizedBox(height: widget.s(8)),
                  _sideBadge("Drawn Time", "02:00 PM",
                      isTime: true),
                ],
              ),
            ],
          ),
          SizedBox(height: widget.s(10)),
          Padding(
            padding:
                EdgeInsets.only(left: widget.s(68)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _numberBadge("A=1", "₹10.0", "x1"),
                      SizedBox(width: widget.s(8)),
                      _numberBadge("B=1", "₹10.0", "x1"),
                      SizedBox(width: widget.s(8)),
                      _numberBadge("C=1", "₹10.0", "x1"),
                    ],
                  ),
                ),

                SizedBox(height: widget.s(14)),

                /// Divider (Full Width)
                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFF3A3942),
                ),

                SizedBox(height: widget.s(12)),

                /// Total Price
                _infoText("Total Price : ", "₹30",
                    isTotal: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoText(String label, String value,
      {bool isTotal = false}) {
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

  Widget _numberBadge(
      String label, String price, String qty) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.s(6),
        vertical: widget.s(4),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius:
            BorderRadius.circular(widget.s(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: widget.s(10),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: widget.s(4)),
          Text(
            price,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: widget.s(8),
            ),
          ),
          SizedBox(width: widget.s(4)),
          Container(
            padding: EdgeInsets.all(widget.s(1)),
            decoration: BoxDecoration(
              color: const Color(0xFFCDB75D),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              qty,
              style: GoogleFonts.dmSans(
                color: Colors.black,
                fontSize: widget.s(6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sideBadge(String label, String value,
      {bool isTime = false}) {
    return Container(
      width: widget.s(80),
      height: widget.s(40),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius:
            BorderRadius.circular(widget.s(6)),
      ),
      child: isTime
          ? Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFF9F9F9F),
                    fontSize: widget.s(8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: widget.s(8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  '$label : ',
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFF9F9F9F),
                    fontSize: widget.s(12),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: widget.s(12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );
  }
}