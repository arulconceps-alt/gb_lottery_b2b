import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFieldWidget extends StatelessWidget {
  final double Function(double) s;

  const SearchFieldWidget({super.key, required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: s(48),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(s(10)),
        border: Border.all(
          color: ColorPalette.border,
          width: 1.2,
        ),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: s(12)),

      child: TextField(
        style: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: s(12),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          height: 20 / 12,
        ),

        decoration: InputDecoration(
          border: InputBorder.none,

          /// Hint text
          hintText: "Search customer by Name or Mobile...",
          hintStyle: GoogleFonts.dmSans(
            color: ColorPalette.searchText,
            fontSize: s(12),
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            height: 20 / 12,
          ),

        /*  /// Optional icon (if in Figma)
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white.withOpacity(0.6),
            size: s(18),
          ),*/
          prefixIconConstraints: BoxConstraints(
            minWidth: s(30),
          ),
        ),
      ),
    );
  }
}