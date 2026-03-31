import 'package:flutter/material.dart';
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
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(s(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// HEADER
          Padding(
            padding: EdgeInsets.only(top: s(14), bottom: s(12)),
            child: Text(
              "Customer Information",
              style: GoogleFonts.dmSans(
                color: const Color(0xFFDFC45C),
                fontSize: s(14),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          /// TOP DIVIDER
          _divider(context),

          /// TABLE
          Column(
            children: [
              _tableRow("Customer name", "Baranee"),
              _divider(context),
              _tableRow("Phone number", "9874563210"),
              _divider(context),
              _tableRow("Customer Id", "56526"),
              _divider(context),
              _tableRow("Pincode", "642120"),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔥 FULL TABLE ROW
  Widget _tableRow(String left, String right) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s(16)), // Padding moved here
      child: SizedBox(
        height: 42,
        child: Row(
          children: [
            Expanded(child: _rowCell(left)),
            Container(
              width: 1,
              color: Colors.white.withOpacity(0.1),
            ),
            Expanded(child: _rowCell(right)),
          ],
        ),
      ),
    );
  }

  /// 🔥 FULL WIDTH DIVIDER
  Widget _divider(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.white.withOpacity(0.08),
    );
  }


  /// 🔥 CELL
  Widget _rowCell(String text) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}