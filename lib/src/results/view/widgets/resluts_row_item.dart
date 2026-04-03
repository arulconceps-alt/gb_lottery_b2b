import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/results/view/widgets/resluts_header_text.dart';

class ReslutsRowItem extends StatelessWidget {
  final List<String> data;

  const ReslutsRowItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s(16), vertical: s(12)),
      child:Row(
  children: [
    Expanded(flex: 2, child: ReslutCellText(data[0])),
    Expanded(flex: 2, child: Center(child: ReslutCellText(data[1]))),

    SizedBox(width: s(40)),

    SizedBox(
      width: s(26),
      height: s(26),
      child: ResultsNumberBox(data[2]),
    ),
    SizedBox(width: s(8)),

    SizedBox(
      width: s(26),
      height: s(26),
      child: ResultsNumberBox(data[3]),
    ),
    SizedBox(width: s(8)),

    SizedBox(
      width: s(26),
      height: s(26),
      child: ResultsNumberBox(data[4]),
    ),
  ],
)
    );
  }
}
