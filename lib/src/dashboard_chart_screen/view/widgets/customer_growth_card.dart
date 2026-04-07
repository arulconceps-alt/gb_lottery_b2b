import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';

class CustomerGrowthCard extends StatefulWidget {
  final double Function(double) s;

  const CustomerGrowthCard({super.key, required this.s});

  @override
  State<CustomerGrowthCard> createState() => _CustomerGrowthCardState();
}

class _CustomerGrowthCardState extends State<CustomerGrowthCard> {
  double s(double value) => widget.s(value);

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    final cardBg = themedata.cardColor;

    return Container(
      width: s(343),
      height: s(416),
      padding: EdgeInsets.symmetric(horizontal: s(12), vertical: s(14)),
      decoration: ShapeDecoration(
        color: cardBg,
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
              'Customer Growth',
              style: TextStyles.dmSans16SemiBold.copyWith(
                color: Colors.white,
                fontSize: s(16),
              ),
            ),
          ),
          SizedBox(height: s(30)),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildYAxis(),
                SizedBox(width: s(10)),
                Expanded(
                  child: Stack(
                    children: [
                      _buildGridLines(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildBarGroup('Jan', 79, 99, 110, cardBg),
                          _buildBarGroup('Feb', 61, 79, 48, cardBg),
                          _buildBarGroup('Mar', 62, 84, 82, cardBg),
                          _buildBarGroup('Apr', 80, 99, 110, cardBg),
                          _buildBarGroup('May', 61, 79, 48, cardBg),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: s(4)),
          _buildXLabels(),
          SizedBox(height: s(24)),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildYAxis() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...['50k', '40k', '30k', '20k', '00'].map((label) => SizedBox(
              height: s(16),
              child: Text(
                label,
                style: TextStyles.dmSans12.copyWith(
                  color: const Color(0xFF9F9F9F),
                  fontSize: s(12),
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
        SizedBox(height: s(24)), // Space for X labels
      ],
    );
  }

  Widget _buildGridLines() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        5,
        (index) => Container(
          height: s(1),
          width: double.infinity,
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
    );
  }

  Widget _buildXLabels() {
    final labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
    return Padding(
      padding: EdgeInsets.only(left: s(35)), // Offset for Y axis
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: labels
            .map((label) => Text(
                  label,
                  style: TextStyles.dmSans12.copyWith(
                    color: const Color(0xFF9F9F9F),
                    fontSize: s(12),
                    fontWeight: FontWeight.w500,
                  ),
                ))
            .toList(),
      ),
    );
  }
  Widget _buildBarGroup(String label, double pink, double blue, double gold, Color cardBg) {
    final gH = s(gold);
    final bH = s(blue);
    final pH = s(pink);

    final double overlap1 = s(15);
    final double overlap2 = s(11);
    final totalHeight = gH + (bH - overlap1) + (pH - overlap2);

    return SizedBox(
      width: s(20),
      height: totalHeight,
      child: CustomPaint(
        size: Size(s(20), totalHeight),
        painter: _BarGroupPainter(
          pinkHeight: pH,
          blueHeight: bH,
          goldHeight: gH,
          overlap1: overlap1,
          overlap2: overlap2,
          pinkColor: const Color(0xFFFF7587),
          blueColor: const Color(0xFF40A0EF),
          goldColor: const Color(0xFFDFC45C),
          cardBg: cardBg,
          s: s,
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem('18-24 yo', const Color(0xFFDFC45C)),
        SizedBox(width: s(16)),
        _legendItem('24-31 yo', const Color(0xFF40A0EF)),
        SizedBox(width: s(16)),
        _legendItem('31+ yo', const Color(0xFFFF7587)),
      ],
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: s(20),
          height: s(20),
          decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(s(4)),
            ),
          ),
        ),
        SizedBox(width: s(8)),
        Text(
          label,
          style: TextStyles.dmSans14.copyWith(
            color: Colors.white,
            fontSize: s(14),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _BarGroupPainter extends CustomPainter {
  final double pinkHeight;
  final double blueHeight;
  final double goldHeight;
  final double overlap1;
  final double overlap2;
  final Color pinkColor;
  final Color blueColor;
  final Color goldColor;
  final Color cardBg;
  final double Function(double) s;

  _BarGroupPainter({
    required this.pinkHeight,
    required this.blueHeight,
    required this.goldHeight,
    required this.overlap1,
    required this.overlap2,
    required this.pinkColor,
    required this.blueColor,
    required this.goldColor,
    required this.cardBg,
    required this.s,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = s(18);
    final radius = s(20);
    final spacerHeight = s(18);
    final spacerRadius = s(9);
    final leftOffset = (size.width - barWidth) / 2;

    // 1. Draw GOLD Segment (Bottom)
    final goldRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(leftOffset, size.height - goldHeight, barWidth, goldHeight),
      Radius.circular(radius),
    );
    canvas.drawRRect(goldRect, Paint()..color = goldColor);

    // 2. Draw Spacer 1 (Over gold)
    final double totalH = goldHeight + (blueHeight - overlap1) + (pinkHeight - overlap2);
    final s1Top = totalH - goldHeight - s(3);
    
    _drawSpacer(canvas, s1Top, size.width, spacerHeight, spacerRadius, cardBg);

    // 3. Draw BLUE Segment (Middle)
    final blueTop = totalH - goldHeight - (blueHeight - overlap1);
    final blueRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(leftOffset, blueTop, barWidth, blueHeight),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );
    canvas.drawRRect(blueRect, Paint()..color = blueColor);

    // 4. Draw Spacer 2 (Over blue)
    final s2Top = pinkHeight - s(14);
    _drawSpacer(canvas, s2Top, size.width, spacerHeight, spacerRadius, cardBg);

    // 5. Draw PINK Segment (Top)
    final pinkRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(leftOffset, 0, barWidth, pinkHeight),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );
    canvas.drawRRect(pinkRect, Paint()..color = pinkColor);
  }

  void _drawSpacer(Canvas canvas, double top, double width, double height, double radius, Color color) {
    final spacerRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, top, width, height),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );
    canvas.drawRRect(spacerRect, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _BarGroupPainter oldDelegate) => true;
}