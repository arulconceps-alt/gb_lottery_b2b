import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/widget/radio_option_widget.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomerDealerSection extends StatelessWidget {
  final double Function(double) s;
  final String selectedType;
  final Function(String) onChanged;

  const CustomerDealerSection({
    super.key,
    required this.s,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: s(30)),

        /// TITLE
        SizedBox(
          width: s(237),
          child: Text(
            "Select Customer or Dealer",
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: s(16),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              height: 20 / 16,
            ),
          ),
        ),

        SizedBox(height: s(21)),

        /// OPTIONS
        Row(
          children: [
            RadioOptionWidget(
              s: s,
              text: "Customer",
              isSelected: selectedType == "Customer",
              onTap: () => onChanged("Customer"),
            ),

            SizedBox(width: s(34)),

            RadioOptionWidget(
              s: s,
              text: "Myself",
              isSelected: selectedType == "Myself",
              onTap: () => onChanged("Myself"),
            ),
          ],
        ),
      ],
    );
  }

}