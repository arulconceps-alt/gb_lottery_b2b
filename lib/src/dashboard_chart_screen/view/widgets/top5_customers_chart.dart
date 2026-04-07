import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerData {
  final String name;
  final double tickets;

  CustomerData(this.name, this.tickets);
}

class Top5CustomersChart extends StatelessWidget {
  final double Function(double) s;
  Top5CustomersChart({super.key, required this.s});

  final List<CustomerData> customers = [
    CustomerData('Sam', 4800),
    CustomerData('Arul', 4200),
    CustomerData('John', 3600),
    CustomerData('Mike', 3100),
    CustomerData('Sara', 2600),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: s(343),
      padding: EdgeInsets.only(
        left: s(12),
        right: s(12),
        top: s(16),
        bottom: s(20),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top 5 Customers',
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: s(16),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: s(24),),
          SizedBox(
            height: s(250),
            child: BarChart(
              BarChartData(
                maxY: 5000,
                minY:2000,
                borderData: FlBorderData(show: false),
                gridData: _buildGrid(),
                titlesData: _buildTitles(),
                alignment: BarChartAlignment.center,
                groupsSpace: s(25),
                baselineY: 0,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) =>
                        Colors.white.withOpacity(0.10),
                    tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    tooltipMargin: 6,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${customers[groupIndex].name}\n',
                        GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text:
                            '${customers[groupIndex].tickets.toInt()} Tickets',
                            style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                barGroups: customers.asMap().entries.map((entry) {
                  return _makeBar(entry.key, entry.value);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeBar(int x, CustomerData data) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: data.tickets,
          color: ColorPalette.option,
          width: s(36), // scaled
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(s(8)),
            topRight: Radius.circular(s(8)),
          ),
        ),
      ],
    );
  }

  FlTitlesData _buildTitles() {
    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: s(30), // reduce width close to 23px
          interval: 1000,   // IMPORTANT: control spacing
          getTitlesWidget: (value, meta) {
            if (value % 1000 != 0) return const SizedBox();

            return SideTitleWidget(
              meta: meta,
              space: s(8), // 👈 THIS CONTROLS GAP BETWEEN TEXT & CHART
              child: SizedBox(
                width: s(23),
                height: s(16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    value == 0 ? '00' : '${(value / 1000).toInt()}k',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.dmSans(
                      fontSize: s(12),
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                      color: ColorPalette.darktext,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: s(32),
          getTitlesWidget: (value, meta) => SideTitleWidget(
            meta: meta,
            child: Text(
              '0${value.toInt() + 1}',
              style: GoogleFonts.dmSans(
                color: ColorPalette.searchText,
                fontSize: s(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  FlGridData _buildGrid() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 1000,
      getDrawingHorizontalLine: (value) => FlLine(
        color: Colors.white.withOpacity(0.05),
        strokeWidth: 1,
      ),
    );
  }
}