import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChartLegend extends StatelessWidget {
  const ChartLegend();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: [
        _legendItem('18-24 yo', const Color(0xFFDFC45C)),
        _legendItem('24-31 yo', const Color(0xFF40A0EF)),
        _legendItem('31+ yo', const Color(0xFFFF7587)),
      ],
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}