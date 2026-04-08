import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/model/customer_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerInfoCard extends StatelessWidget {
  final double Function(double) s;
  final CustomerModel customer;

  const CustomerInfoCard({
    super.key,
    required this.s,
    required this.customer,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(s(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// HEADER
          Padding(
            padding: EdgeInsets.only(top: s(7),bottom: s(11)),
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
          _buildTableRow("Customer name", customer.name),
          _buildTableRow("Phone number", customer.phone),
          _buildTableRow("Customer Id", customer.id),
          // Last row doesn't need a bottom divider
          _buildTableRow("Pincode", customer.pincode, isLast: true),
        ],
      ),
    );
  }

  Widget _buildTableRow(String label, String value, {bool isLast = false}) {
    final TextStyle valueStyle = GoogleFonts.dmSans(
      color: Colors.white,
      fontSize: s(12),
      fontWeight: FontWeight.w400,
      height: 1.67,
    );

    // Label style (keeping original color or similar)
    final TextStyle labelStyle = GoogleFonts.dmSans(
      color: const Color(0xFF9F9F9F), // Using a muted gray for labels
      fontSize: s(12),
      fontWeight: FontWeight.w400,
      height: 1.67,
    );
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.white.withOpacity(0.1),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _rowCell(label,labelStyle),
              ),

              // 🔥 VERTICAL CENTER DIVIDER (Top to Bottom)
              Container(
                width: 1,
                color: Colors.white.withOpacity(0.1),
              ),

              // RIGHT SIDE (Value)
              Expanded(
                child: _rowCell(value,valueStyle),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _rowCell(String text,TextStyle style) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: s(30)),
      padding: EdgeInsets.only(top: s(5), bottom: s(9)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}