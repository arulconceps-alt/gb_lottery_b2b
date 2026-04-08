import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final List<Map<String, String>> aprilTransactions = [
    {'date': 'April 6, 02:00pm'},
    {'date': 'April 5, 02:00pm'},
    {'date': 'April 4, 02:00pm'},
    {'date': 'April 3, 02:00pm'},
    {'date': 'April 2, 02:00pm'},
    {'date': 'April 1, 02:00pm'},
  ];

  final List<Map<String, String>> marchTransactions = [
    {'date': 'March 31, 02:00pm'},
    {'date': 'March 30, 02:00pm'},
    {'date': 'March 29, 02:00pm'},
    {'date': 'March 28, 02:00pm'},
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1116),
      appBar: AppBarTextWithBack(title: "Transaction"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(s(16)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: s(38), // ✅ exact Figma height
                    padding: EdgeInsets.symmetric(horizontal: s(14)),
                    decoration: BoxDecoration(
                      color: const Color(0xFF24232A),
                      borderRadius: BorderRadius.circular(s(8)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Date",
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: s(14),
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(width: s(4)),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.white,
                          size: s(18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              _monthSection(
                s,
                month: "April",
                year: "2026",
                total: "+ ₹25,00,000",
                transactions: aprilTransactions,
              ),

              SizedBox(height: s(16)),

              _monthSection(
                s,
                month: "March",
                year: "2026",
                total: "+ ₹20,00,000",
                transactions: marchTransactions,
              ),
              SizedBox(height:s(27)),
            ],
          ),

        ),
      ),
    );
  }

  Widget _monthSection(
      double Function(double) s, {
        required String month,
        required String year,
        required String total,
        required List<Map<String, String>> transactions,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Month header full width
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: s(14),
            vertical: s(14),
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF24232A),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    year,
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: s(12),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: s(4)),
                  Text(
                    month,
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: s(20),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                total,
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: s(18),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        /// Cards spacing
        ...transactions.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return Padding(
            padding: EdgeInsets.only(
              left: s(16),
              right: s(16),
              top: index == 0 ? s(12) : 0, // ✅ first card top spacing
              bottom: s(12), // ✅ card to card spacing
            ),
            child: _transactionCard(s, item['date']!),
          );
        }),
      ],
    );
  }

  Widget _transactionCard(double Function(double) s, String date) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s(14)),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// top row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wallet Credit",
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: s(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "+ ₹5,00,000",
                style: GoogleFonts.dmSans(
                  color: const Color(0xFF1DFD0D),
                  fontSize: s(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: s(8)),

          Text(
            "Balance Updated Successfully",
            style: GoogleFonts.dmSans(
              color: const Color(0xFF9F9F9F),
              fontSize: s(12),
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: s(6)),

          Text(
            date,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: s(12),
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: s(12)),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          SizedBox(height: s(12)),

          Text(
            "TNX ID : 901253462454",
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: s(12),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}