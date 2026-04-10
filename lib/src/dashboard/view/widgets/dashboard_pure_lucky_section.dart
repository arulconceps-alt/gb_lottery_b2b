import 'package:flutter/material.dart';

class DashboardPureLuckySection extends StatelessWidget {
  const DashboardPureLuckySection({super.key});

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
          crossAxisCount: 4,
          crossAxisSpacing: s(10),
          mainAxisSpacing: s(13),
          childAspectRatio: s(75) / s(87),
        ),
        itemBuilder: (context, index) {
          return Column(
              mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: s(75),
                height: s(87),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/dashboard/pure_frame.webp"),
                    fit: BoxFit.cover,
                  ),
                 // borderRadius: BorderRadius.circular(s(6)),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  images[index],
                  width: s(66),
                  height: s(76),
                  fit: BoxFit.contain,
                ),
              ),

              // SizedBox(height: s(6)),
              // Text(
              //   "Game ${(index + 1).toString().padLeft(2, '0')}",
              //   style: GoogleFonts.inter(
              //     fontSize: s(8),
              //     fontWeight: FontWeight.w400,
              //     height: 11 / 8,
              //     letterSpacing: 0,
              //     color: Colors.white,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
            ],
          );
        },
      ),
    );
  }
}
