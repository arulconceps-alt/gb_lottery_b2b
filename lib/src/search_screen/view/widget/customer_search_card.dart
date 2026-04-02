import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerSearchCard extends StatelessWidget {
  final double Function(double) s;
  final String name;
  final String pincode;
  final String phone;
  final String initial;
  final bool isFirst; // Add this to handle the top radius

  const CustomerSearchCard({
    super.key,
    required this.s,
    required this.name,
    required this.pincode,
    required this.phone,
    required this.initial,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: s(70),
      decoration: BoxDecoration(
        color:  ColorPalette.backgroundDark,
        // Only round the top corners of the very first card
        borderRadius: isFirst
            ? BorderRadius.vertical(top: Radius.circular(s(10)))
            : BorderRadius.zero,
        border: Border(
          left: BorderSide(color: Colors.white.withOpacity(0.1)),
          right: BorderSide(color: Colors.white.withOpacity(0.1)),
          bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
          // Only add top border to the first item to avoid double borders between cards
          top: isFirst
              ? BorderSide(color: Colors.white.withOpacity(0.1))
              : BorderSide.none,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: s(10)),
      child: Row(
        children: [
          Container(
            width: s(50),
            height: s(50),
            decoration: const BoxDecoration(
              color: Color(0xFF1F1E24),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: s(24),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: s(12)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name , $pincode',
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(16),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: s(4)),
                Text(
                  phone,
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFF9F9F9F),
                    fontSize: s(14),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}