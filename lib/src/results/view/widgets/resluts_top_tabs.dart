import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsTopTabs extends StatefulWidget {
  const ResultsTopTabs({super.key});

  @override
  State<ResultsTopTabs> createState() => _ResultsTopTabsState();
}

class _ResultsTopTabsState extends State<ResultsTopTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final tabs = ["All", "Arunachal Pradesh", "Assam", "Goa", "Kerala"];

    return SizedBox(
      height: s(36),
      child: ListView.separated(
        padding: EdgeInsets.only(right: s(10)),
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => SizedBox(width: s(10)),
        itemBuilder: (_, i) {
          final isSelected = selectedIndex == i;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = i;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: EdgeInsets.symmetric(horizontal: s(14)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: isSelected ? ColorPalette.buttonGradient : null,
                color: !isSelected ? const Color(0xFF2A2933) : null,
                borderRadius: BorderRadius.circular(s(8)),
              ),
              child: Text(
                tabs[i],
                style: GoogleFonts.dmSans(
                  fontSize: s(14),
                  color: ColorPalette.whitetext,
                  fontWeight:  FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
