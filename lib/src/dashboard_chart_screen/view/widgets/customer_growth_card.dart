import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerGrowthCard extends StatelessWidget {
  const CustomerGrowthCard({super.key});

  @override
  Widget build(BuildContext context) {
    const Color cardBg = Color(0xFF24232A);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Growth',
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 250,
            child: Row(
              children: [
                _buildYAxis(),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStackedBar('Jan', 0.9, 0.7, 0.45, cardBg),
                      _buildStackedBar('Feb', 0.5, 0.4, 0.25, cardBg),
                      _buildStackedBar('Mar', 0.8, 0.5, 0.4, cardBg),
                      _buildStackedBar('Apr', 0.95, 0.75, 0.5, cardBg),
                      _buildStackedBar('May', 0.6, 0.45, 0.2, cardBg),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildYAxis() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...['50k', '40k', '30k', '20k', '00'].map((label) => Text(
          label,
          style: GoogleFonts.dmSans(color: const Color(0xFF9F9F9F), fontSize: 12),
        )),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStackedBar(String label, double pink, double blue, double yellow, Color bg) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: 18,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // 1. PINK: Tallest (Draw first/Background)
                _barSegment(heightFactor: pink, color: const Color(0xFFFF7587)),
SizedBox(height: 10,),
                // 2. BLUE: Middle (Draw second)
                // We add a cutout to the BOTTOM of Blue to show Pink behind it
                _barSegment(
                  heightFactor: blue,
                  color: const Color(0xFF40A0EF),
                  hasBottomCutout: true,
                  bg: bg,
                ),
                SizedBox(height: 2,),
                // 3. YELLOW: Shortest (Draw last/Foreground)
                // This remains a SOLID pill at the bottom to match Figma
                _barSegment(
                  heightFactor: yellow,
                  color: const Color(0xFFDFC45C),
                  hasBottomCutout: false, // NO cutout here!
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(label, style: GoogleFonts.dmSans(color: const Color(0xFF9F9F9F), fontSize: 12)),
      ],
    );
  }

  Widget _barSegment({
    required double heightFactor,
    required Color color,
    bool hasBottomCutout = false,
    Color? bg,
  }) {
    return FractionallySizedBox(
      heightFactor: heightFactor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // The Pill
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          // The Gap Cutout (Only if specified)
          if (hasBottomCutout)
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: bg, // This matches the card background
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
        ],
      ),
    );
  }



  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem('18-24 yo', const Color(0xFFDFC45C)),
        const SizedBox(width: 16),
        _legendItem('24-31 yo', const Color(0xFF40A0EF)),
        const SizedBox(width: 16),
        _legendItem('31+ yo', const Color(0xFFFF7587)),
      ],
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.dmSans(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}