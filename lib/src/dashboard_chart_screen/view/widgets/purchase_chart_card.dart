import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class PurchaseChartCard extends StatefulWidget {
  final double Function(double) s;

  const PurchaseChartCard({super.key, required this.s});

  @override
  State<PurchaseChartCard> createState() => _PurchaseChartCardState();
}

class _PurchaseChartCardState extends State<PurchaseChartCard> {
  int selectedIndex = 1;

  final List<String> labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];

  double s(double value) => widget.s(value);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s(16)),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(s(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Purchase Tickets',
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: s(16),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: s(24)),

          /// ✅ Chart
          SizedBox(
            height: s(250),
            child: LineChart(mainData()),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      /// ✅ REMOVE INTERNAL EXTRA SPACE
      clipData: FlClipData.all(),

      /// ✅ ALIGN CHART PERFECTLY
      baselineX: 0,

      /// ✅ GRID (FIGMA STYLE)
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 10000,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white.withOpacity(0.05),
            strokeWidth: s(1),
            dashArray: [4, 4],
          );
        },
      ),

      /// ✅ TITLES
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),

        /// 🔥 X AXIS (NO DUPLICATE)
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: s(42), // total bottom height
            getTitlesWidget: (value, meta) {
              final index = value.toInt();

              if (index < 0 || index >= labels.length) {
                return const SizedBox();
              }

              return SideTitleWidget(
                meta: meta,
                space: s(24),
                child: Text(
                  labels[index],
                  style: GoogleFonts.dmSans(
                    fontSize: s(12),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF9F9F9F),
                  ),
                ),
              );
            },
          ),
        ),

        /// 🔥 Y AXIS (TIGHT LIKE FIGMA)
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: s(34),
            interval: 10000,
            getTitlesWidget: (value, meta) {
              String text = '';
              if (value == 0) text = '00';
              else if (value >= 1000) text = '${(value / 1000).toInt()}k';

              if (text.isEmpty) return const SizedBox();

              return SideTitleWidget(
                meta: meta,
                space: s(8),
                child: Text(
                  text,
                  style: GoogleFonts.dmSans(
                    fontSize: s(12),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF9F9F9F),
                  ),
                ),
              );
            },
          ),
        ),
      ),

      borderData: FlBorderData(show: false),

      /// ✅ RANGE
      minX: 0,
      maxX: 4,
      minY: 0,
      maxY: 50000,

      /// ✅ LINE DATA
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 38000),
            FlSpot(1, 35420),
            FlSpot(2, 45000),
            FlSpot(3, 36000),
            FlSpot(4, 38000),
          ],
          isCurved: true,
          preventCurveOverShooting: true,
          barWidth: s(2),
          isStrokeCapRound: true,
          gradient: const LinearGradient(
            colors: [Color(0xFFDFC45C), Color(0xFFDFC45C)],
          ),

          /// ✅ DOT
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              if (index == selectedIndex) {
                return FlDotCirclePainter(
                  radius: s(6),
                  color: const Color(0xFFDFC45C),
                  strokeWidth: s(2),
                  strokeColor: Colors.white,
                );
              }
              return FlDotCirclePainter(radius: 0);
            },
          ),

          /// ✅ AREA
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFDFC45C).withOpacity(0.3),
                const Color(0xFFDFC45C).withOpacity(0.0),
              ],
            ),
          ),
        ),
      ],


      /// ✅ TOUCH DISABLED
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: true,
        touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
          if (!event.isInterestedForInteractions ||
              response == null ||
              response.lineBarSpots == null ||
              response.lineBarSpots!.isEmpty) {
            return;
          }

          final spotIndex = response.lineBarSpots!.first.spotIndex;

          if (selectedIndex != spotIndex) {
            setState(() {
              selectedIndex = spotIndex;
            });
          }
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBorderRadius: BorderRadius.circular(s(8)),
          tooltipPadding: EdgeInsets.symmetric(
            horizontal: s(10),
            vertical: s(6),
          ),
          tooltipMargin: -s(35), // ✅ BELOW THE LINE
          getTooltipColor: (touchedSpot) => const Color(0xFF2E2D35),
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                '${spot.y.toInt()}',
                GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: s(12),
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}