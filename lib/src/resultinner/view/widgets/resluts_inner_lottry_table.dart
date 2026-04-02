import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/resultinner/view/widgets/resluts_inner_header_text.dart';
import 'package:gb_lottery_b2b/src/resultinner/view/widgets/resluts_inner_row_item.dart'
    show ResultInnerRowItem;
import 'package:google_fonts/google_fonts.dart';

class ResultInnerLotteryTable extends StatefulWidget {

  const ResultInnerLotteryTable({super.key});

  @override
  State<ResultInnerLotteryTable> createState() => _ResultInnerLotteryTableState();
}

class _ResultInnerLotteryTableState extends State<ResultInnerLotteryTable> {
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    final data = [
      ["19/01/2026", "15.00 PM", "6", "2", "1"],
      ["18/01/2026", "15.00 PM", "5", "3", "1"],
      ["17/01/2026", "15.00 PM", "6", "6", "6"],
      ["16/01/2026", "15.00 PM", "4", "2", "5"],
      ["15/01/2026", "15.00 PM", "2", "2", "2"],
      ["19/01/2026", "15.00 PM", "6", "2", "1"],
      ["18/01/2026", "15.00 PM", "5", "3", "1"],
      ["17/01/2026", "15.00 PM", "6", "6", "6"],
       ["16/01/2026", "15.00 PM", "4", "2", "5"],
      ["15/01/2026", "15.00 PM", "2", "2", "2"],
      ["19/01/2026", "15.00 PM", "6", "2", "1"],
      ["18/01/2026", "15.00 PM", "5", "3", "1"],
      ["17/01/2026", "15.00 PM", "6", "6", "6"],
    ];

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF313038),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: s(16), horizontal: s(16)),
            child: Row(
              children: [
                Expanded(flex: 3, child: ResultInnerHeaderText("Date")),
                Expanded(flex: 2, child: ResultInnerHeaderText("Time")),

                Expanded(
                  flex: 1,
                  child: Center(child: ResultsInnerCircleHeader("A")),
                ),
                Expanded(
                  flex: 1,
                  child: Center(child: ResultsInnerCircleHeader("B")),
                ),
                Expanded(
                  flex: 1,
                  child: Center(child: ResultsInnerCircleHeader("C")),
                ),
              ],
            ),
          ),
        ),

        /// Rows
        Container(
          decoration: const BoxDecoration(
            color:  ColorPalette.backgroundDark,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Column(
            children: data.map((e) => ResultInnerRowItem(data: e)).toList(),
          ),
        ),

         SizedBox(height: s(26)),

            Padding(
          padding: EdgeInsets.symmetric(horizontal: s(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total 25004",
                style: GoogleFonts.dmSans(
                  fontSize: s(14),
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.darktext,
                ),
              ),

              SizedBox(width: s(24)),

              Row(
                children: [
                  _pageNumber("1", selectedPage == 1, s),
                  SizedBox(width: s(24)),
                  _pageNumber("2", selectedPage == 2, s),
                  SizedBox(width: s(24)),
                  _pageNumber("3", selectedPage == 3, s),
                  SizedBox(width: s(24)),
                  _navButton(Icons.chevron_left, s),
                  SizedBox(width: s(7)),
                  _navButton(Icons.chevron_right, s),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: s(40)),
      ],
    );
  }

  Widget _pageNumber(String text, bool isSelected, double Function(double) s) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPage = int.parse(text);
        });
      },
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: s(14),
          fontWeight: FontWeight.w600,
          color: isSelected
              ? ColorPalette.whitetext
              : ColorPalette.darktext,
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, double Function(double) s) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (icon == Icons.chevron_left && selectedPage > 1) {
            selectedPage--;
          } else if (icon == Icons.chevron_right && selectedPage < 3) {
            selectedPage++;
          }
        });
      },
      child: Container(
        height: s(26),
        width: s(26),
        decoration: BoxDecoration(
          color: const Color(0xFF313038),
          borderRadius: BorderRadius.circular(s(6)),
        ),
        child: Icon(icon, size: s(12), color: ColorPalette.whitetext),
      ),
    );
}
}