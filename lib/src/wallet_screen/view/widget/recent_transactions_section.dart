import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentTransactionsSection extends StatelessWidget {
  const RecentTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final List<Map<String, String>> transactions = [
      {'date': 'April 6, 02:00pm', 'amount': '+ ₹5,00,000', 'id': '901253462454'},
      {'date': 'April 5, 02:00pm', 'amount': '+ ₹5,00,000', 'id': '901253462454'},
      {'date': 'April 4, 02:00pm', 'amount': '+ ₹5,00,000', 'id': '901253462454'},
      {'date': 'April 3, 02:00pm', 'amount': '+ ₹5,00,000', 'id': '901253462454'},
      {'date': 'April 2, 02:00pm', 'amount': '+ ₹5,00,000', 'id': '901253462454'},
    ];

    return Container(
      padding: EdgeInsets.all(s(16)),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(s(12)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: s(18),
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => context.push('/transaction'),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: s(12),
                    vertical: s(6),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1E24),
                    borderRadius: BorderRadius.circular(s(10)),
                  ),
                  child: Text(
                    'See All',
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: s(14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: s(16)),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: s(12)),
            itemBuilder: (context, index) {
              final item = transactions[index];
              return TransactionTile(
                date: item['date']!,
                amount: item['amount']!,
                txnId: item['id']!,
              );
            },
          ),
        ],
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String date;
  final String amount;
  final String txnId;

  const TransactionTile({
    super.key,
    required this.date,
    required this.amount,
    required this.txnId,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Container(
      padding: EdgeInsets.all(s(14)),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E24),
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Wallet Credit',
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: s(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                amount,
                style: GoogleFonts.dmSans(
                  color: const Color(0xFF1DFD0D),
                  fontSize: s(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: s(4)),

          Text(
            'Balance Updated Successfully',
            style: GoogleFonts.dmSans(
              color: const Color(0xFF9F9F9F),
              fontSize: s(12),
            ),
          ),

          SizedBox(height: s(4)),

          Text(
            date,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: s(12),
            ),
          ),

          SizedBox(height: s(12)),

          Divider(color: Colors.white24, height: s(1)),

          SizedBox(height: s(8)),

          Text(
            'TNX ID : $txnId',
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: s(12),
            ),
          ),
        ],
      ),
    );
  }
}