import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';

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
    final themedata = Theme.of(context);

    return Container(
      width: s(343),
      height: s(379),
      padding: EdgeInsets.only(
        left: s(0), // Padding handled inside fl_chart for alignment
        top: s(14),
        right: s(16),
        bottom: s(16),
      ),
      decoration: ShapeDecoration(
        color: themedata.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(s(8)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: s(9)),
            child: Text(
              'Total Purchase Tickets',
              style: TextStyles.dmSans16SemiBold.copyWith(
                color: Colors.white,
                fontSize: s(16),
              ),
            ),
          ),
          SizedBox(height: s(30)),
          Expanded(child: LineChart(mainData(themedata))),
        ],
      ),
    );
  }

  LineChartData mainData(ThemeData themedata) {
    // REQUIRED: We must define the bar data as a variable to reference it below in showingTooltipIndicators
    final barData = LineChartBarData(
      spots: const [
        FlSpot(0, 32000),
        FlSpot(1, 35420),
        FlSpot(2, 45000),
        FlSpot(3, 28000),
        FlSpot(4, 38000),
      ],
      isCurved: true,
      barWidth: s(2),
      isStrokeCapRound: true,
      color: themedata.colorScheme.primary,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          if (index == selectedIndex) {
            return FlDotCirclePainter(
              radius: s(5),
              color: themedata.colorScheme.primary,
              strokeWidth: s(2),
              strokeColor: Colors.white,
            );
          }
          return FlDotCirclePainter(radius: 0);
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            themedata.colorScheme.primary.withValues(alpha: 0.2),
            themedata.colorScheme.primary.withValues(alpha: 0.0),
          ],
        ),
      ),
    );

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 10000,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white.withValues(alpha: 0.05),
            strokeWidth: s(1),
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: s(30),
            interval: 1,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= labels.length) return const SizedBox();
              return SideTitleWidget(
                meta: meta,
                space: s(12),
                child: Text(
                  labels[index],
                  style: TextStyles.dmSans12.copyWith(
                    color: const Color(0xFF9F9F9F),
                    fontSize: s(12),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: s(45),
            interval: 10000,
            getTitlesWidget: (value, meta) {
              String text = '';
              if (value == 0)
                text = '00';
              else if (value >= 1000)
                text = '${(value / 1000).toInt()}k';

              return SideTitleWidget(
                meta: meta,
                space: s(10),
                child: Text(
                  text,
                  style: TextStyles.dmSans12.copyWith(
                    color: const Color(0xFF9F9F9F),
                    fontSize: s(12),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 4,
      minY: 0,
      maxY: 50000,
      lineBarsData: [barData],
      // 🔥 THIS ENSURES THE VALUE IS ALWAYS VISIBLE AND UPDATES ON DRAG
      showingTooltipIndicators: [
        ShowingTooltipIndicators([
          LineBarSpot(barData, 0, barData.spots[selectedIndex]),
        ]),
      ],
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: false, // We handle tooltips via selection state
        touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
          if (response == null || response.lineBarSpots == null) return;
          if (response.lineBarSpots!.isNotEmpty) {
            setState(() {
              selectedIndex = response.lineBarSpots!.first.spotIndex;
            });
          }
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => Colors.transparent,
          tooltipBorderRadius: BorderRadius.circular(s(0)),
          tooltipMargin: -s(28),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              final valueStr = spot.y.toInt().toString().replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]},',
              );
              return LineTooltipItem(
                valueStr,
                TextStyles.dmSans12.copyWith(
                  color: Colors.white,
                  fontSize: s(12),
                  fontWeight: FontWeight.w400,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
