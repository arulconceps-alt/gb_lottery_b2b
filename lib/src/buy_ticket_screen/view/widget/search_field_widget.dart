import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFieldWidget extends StatelessWidget {
  final double Function(double) s;
  final VoidCallback onTap;

  const SearchFieldWidget({
    super.key,
    required this.s,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(s(10)),
      child: Container(
        width: double.infinity,
        height: s(48),
        decoration: BoxDecoration(
          // Background Color: #24232A
          color: const Color(0xFF24232A),
          borderRadius: BorderRadius.circular(s(10)),
          // Border Color: #1F1E24
          border: Border.all(
            color: const Color(0xFF1F1E24),
            width: 1.2,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: s(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "Search customer by Name or Mobile...",
                style: GoogleFonts.dmSans(
                  // Selection/Hint Color: #9F9F9F
                  color: const Color(0xFF9F9F9F),
                  fontSize: s(12),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}