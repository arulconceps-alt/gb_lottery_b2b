import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/results/view/widgets/resluts_header_text.dart';
import 'package:gb_lottery_b2b/src/results/view/widgets/resluts_row_item.dart';

class LotteryTable extends StatelessWidget {
  const LotteryTable({super.key});

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
      decoration: const BoxDecoration(
        color: Color(0xFF313038),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: s(16), horizontal: s(16) ),
        child: Row(
          children:  [
            Expanded(child: ReslutsHeaderText("Date")),
            SizedBox(width: s(93)),
            Expanded(child: ReslutsHeaderText("Time")),
             SizedBox(width: s(52)),
            ResultsCircleHeader("A"),
             SizedBox(width: s(8)),
            ResultsCircleHeader("B"),
             SizedBox(width: s(8)),
            ResultsCircleHeader("C"),
          ],
        ),
      ),
    ),

    /// Rows
    Container(
      decoration: const BoxDecoration(
        color: Color(0xFF24232A),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: Column(
        children: data
            .map((e) => ReslutsRowItem(data: e))
            .toList(),
      ),
    ),
  ],
);
  }
}