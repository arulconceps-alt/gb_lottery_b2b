import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerInfoCard extends StatelessWidget {
  final double Function(double) s;

  const CustomerInfoCard({
    super.key,
    required this.s,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color:  ColorPalette.backgroundDark,
        borderRadius: BorderRadius.circular(s(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// HEADER
          Padding(
            padding: EdgeInsets.symmetric(vertical: s(12)),
            child: Text(
              "Customer Information",
              style: GoogleFonts.dmSans(
                color: const Color(0xFFDFC45C),
                fontSize: s(14),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          /// TABLE BODY
          _buildTableRow("Customer name", "Baranee T"),
          _buildTableRow("Phone number", "9874563210"),
          _buildTableRow("Customer Id", "56526"),
          // Last row doesn't need a bottom divider
          _buildTableRow("Pincode", "642120", isLast: true),
        ],
      ),
    );
  }

  Widget _buildTableRow(String label, String value, {bool isLast = false}) {
    return Column(
      children: [
        // Horizontal divider ABOVE the row
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.white.withOpacity(0.1),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // LEFT SIDE (Label)
              Expanded(
                child: _rowCell(label),
              ),

              // 🔥 VERTICAL CENTER DIVIDER (Top to Bottom)
              Container(
                width: 1,
                color: Colors.white.withOpacity(0.1),
              ),

              // RIGHT SIDE (Value)
              Expanded(
                child: _rowCell(value),
              ),
            ],
          ),
        ),
        // If it's the last row, we add a final bottom divider to close the box
        if (isLast)
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.white.withOpacity(0.1),
          ),
      ],
    );
  }

  Widget _rowCell(String text) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: s(42)),
      padding: EdgeInsets.symmetric(vertical: s(10), horizontal: s(8)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: s(12),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}