import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryDropdownWidget extends StatelessWidget {
  final double Function(double) s;
  final String text; // This acts as the placeholder/hint
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String> onSelected;

  const LotteryDropdownWidget({
    super.key,
    required this.s,
    required this.text,
    required this.items,
    this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // FILTER: Only include items that ARE NOT the currently selected value
    final displayItems = items.where((item) => item != selectedValue).toList();

    return PopupMenuButton<String>(
      onSelected: onSelected,
      offset: Offset(0, s(70)), // Positioned exactly below the bar
      elevation: 0,
      color: const Color(0xFF24232A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(s(12)),
        side: const BorderSide(color: Color(0xFF313038), width: 1),
      ),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width - s(32),
        maxWidth: MediaQuery.of(context).size.width - s(32),
      ),
      itemBuilder: (context) {
        // Use the filtered list here
        return displayItems.map((item) {
          return PopupMenuItem<String>(
            value: item,
            height: s(48),
            child: Text(
              item,
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontSize: s(15),
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList();
      },
      child: Container(
        width: double.infinity,
        height: s(66),
        padding: EdgeInsets.symmetric(horizontal: s(16)),
        decoration: BoxDecoration(
          color: const Color(0xFF24232A),
          borderRadius: BorderRadius.circular(s(10)),
          border: Border.all(
            color: const Color(0xFF313038),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedValue ?? text, // Shows selected item or hint
                style: GoogleFonts.dmSans(
                  color: selectedValue != null ? Colors.white : const Color(0xFF9F9F9F),
                  fontSize: s(15),
                  fontWeight: FontWeight.w600,
                  fontStyle: selectedValue != null ? FontStyle.normal : FontStyle.italic,
                ),
              ),
            ),
            Image.asset(
              "assets/images/buy_ticket/ep_arrow-down-bold.webp",
              height: s(16),
              width: s(16),
            ),
          ],
        ),
      ),
    );
  }
}