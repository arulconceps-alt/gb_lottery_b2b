import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/results/view/widgets/resluts_header_text.dart';
import 'package:gb_lottery_b2b/src/results/view/widgets/resluts_row_item.dart';

class ReslutsLottryTable extends StatelessWidget {
  const ReslutsLottryTable({super.key});

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
    ];

    return Column(
      children: [
        Container(
          height: s(48),
          decoration: const BoxDecoration(
            color: ColorPalette.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: s(16), vertical: s(12)),
            child: Row(
              children: [
                Expanded(flex: 2, child: ReslutsHeaderText("Date")),
                Expanded(
                  flex: 2,
                  child: Center(child: ReslutsHeaderText("Time")),
                ),

                SizedBox(width: s(40)), // small gap

                SizedBox(
                  width: s(26),
                  child: Center(child: ResultsCircleHeader("A")),
                ),
                SizedBox(width: s(8)),

                SizedBox(
                  width: s(26),
                  child: Center(child: ResultsCircleHeader("B")),
                ),
                SizedBox(width: s(8)),

                SizedBox(
                  width: s(26),
                  child: Center(child: ResultsCircleHeader("C")),
                ),
              ],
            ),
          ),
        ),

        /// Rows
        Container(
          decoration: const BoxDecoration(
            color: ColorPalette.backgroundDark,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Column(
            children: data.map((e) => ReslutsRowItem(data: e)).toList(),
          ),
        ),
      ],
    );
  }
}
