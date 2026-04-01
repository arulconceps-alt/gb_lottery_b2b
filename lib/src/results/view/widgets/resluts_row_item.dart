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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Row(
        children: [
          Expanded(child: ReslutCellText(data[0])),
           SizedBox(width: s(43)),
          Expanded(child: ReslutCellText(data[1])),
          ResultsNumberBox(data[2]),
          ResultsNumberBox(data[3]),
          ResultsNumberBox(data[4]),
        ],
      ),
    );
  }
}