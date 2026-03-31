import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboradPureluckySectionCard extends StatelessWidget {
  const DashboradPureluckySectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final List<String> images = [
      "assets/images/dashboard/game1.webp",
      "assets/images/dashboard/game2.webp",
      "assets/images/dashboard/game3.webp",
      "assets/images/dashboard/game4.webp",
      "assets/images/dashboard/game5.webp",
      "assets/images/dashboard/game6.webp",
      "assets/images/dashboard/game7.webp",
      "assets/images/dashboard/game8.webp",
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s(16)),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4 per row → total 2 rows
          crossAxisSpacing: s(12),
          mainAxisSpacing: s(12),
          childAspectRatio: s(72) / s(100), // container + text space
        ),
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔹 CONTAINER
              Container(
                width: s(72),
                height: s(84),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2B33),
                  borderRadius: BorderRadius.circular(s(10)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(images[index], fit: BoxFit.cover),
              ),

              SizedBox(height: s(6)),
              Text(
                "Game ${(index + 1).toString().padLeft(2, '0')}",
                style: GoogleFonts.inter(
                  fontSize: s(8),
                  fontWeight: FontWeight.w400,
                  height: 11 / 8,
                  letterSpacing: 0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
