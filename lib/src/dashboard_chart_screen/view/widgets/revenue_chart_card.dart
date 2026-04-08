import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class RevenueChartCard extends StatelessWidget {
  const RevenueChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorPalette.backgroundDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Keep column compact
        children: [
          Text(
            'Revenue Chart',
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          // Centered Pie Chart with Outside Labels
          SizedBox(
            height: 240, // Increased slightly for labels
            child: PieChart(
                PieChartData(
                  sectionsSpace: 1,
                  centerSpaceRadius: 0,
                  startDegreeOffset: -90,
                  sections: _getSections(),
                ),
            ),
          ),
          const SizedBox(height: 30),
          _buildRevenueItem('Kerala Lottery', '₹2,75,384', '52%', ColorPalette.revenue,),
          _buildRevenueItem('Goa Lottery', '₹25,384', '5%', ColorPalette.revenue1,),
          _buildRevenueItem('Assam Lottery', '₹50,000', '10%', ColorPalette.revenue2,),
          _buildRevenueItem('Arunachal Lottery', '₹75,000', '15%',ColorPalette.revenue3,),
          _buildRevenueItem('Manipur Lottery', '₹90,384', '18%', ColorPalette.revenue4,),
        ],
      ),
    );
  }

  List<PieChartSectionData> _getSections() {
    return [
      _section(52, ColorPalette.revenue, '52%'), // Blue top big
      _section(5, ColorPalette.revenue1, '5%'),   // Green right
      _section(10,ColorPalette.revenue2, '10%'), // Yellow bottom right
      _section(15, ColorPalette.revenue3, '15%'), // Pink bottom
      _section(18, ColorPalette.revenue4, '18%'), // Purple left
    ];
  }

  PieChartSectionData _section(double value, Color color, String title) {
    return PieChartSectionData(
      value: value,
      color: color,
      radius: 88,
      showTitle: true,
      title: title,
      titlePositionPercentageOffset: 1.28,
      titleStyle: GoogleFonts.inter(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildRevenueItem(String name, String amount, String percent, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                percent,
                style: GoogleFonts.dmSans(
                  color:ColorPalette.darktext,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}