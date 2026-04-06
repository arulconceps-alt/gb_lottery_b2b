import 'package:flutter/material.dart';

class DashboardFantasyScrollSection extends StatefulWidget {
  const DashboardFantasyScrollSection({super.key});

  @override
  State<DashboardFantasyScrollSection> createState() =>
      _DashboardFantasyScrollSectionState();
}

class _DashboardFantasyScrollSectionState
    extends State<DashboardFantasyScrollSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final itemWidth = s(140);
    final spacing = s(12);

    final totalWidth = (itemWidth * 3) + (spacing * 2); // 3 items

    return SizedBox(
      height: s(66),
      child: Padding(
        padding: EdgeInsets.only(left: s(12)), // ✅ left space 12
        child: ClipRect(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final offset = _controller.value * totalWidth;

              return Transform.translate(
                offset: Offset(-offset, 0),
                child: SizedBox(
                  width: totalWidth * 2, // ✅ prevents Row overflow
                  child: Row(
                    children: [
                      _buildItems(itemWidth, spacing, s),
                      SizedBox(width: spacing),
                      _buildItems(itemWidth, spacing, s),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // 🔹 ITEMS ROW
  Widget _buildItems(double itemWidth, double spacing, double Function(double) s) {
    return Row(
      children: [
        _card("assets/images/dashboard/icc.webp", itemWidth, s),
        SizedBox(width: spacing),
        _card("assets/images/dashboard/ipl.webp", itemWidth, s),
        SizedBox(width: spacing),
        _card("assets/images/dashboard/hocky.webp", itemWidth, s),
      ],
    );
  }

  // 🔹 CARD
  Widget _card(String image, double width, double Function(double) s) {
    return Container(
      width: width,
      height: s(66),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(s(12)),
        color: Colors.black,
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}