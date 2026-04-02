import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/resultinner/view/widgets/resluts_inner_header_text.dart';

class ResultInnerRowItem extends StatelessWidget {
  final List<String> data;

  const ResultInnerRowItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Row(
        children: [
          Expanded(flex: 3, child: ReslutInnerCellText(data[0])),
          Expanded(flex: 2, child: ReslutInnerCellText(data[1])),

          Expanded(
            flex: 1,
            child: Center(child: ResultInnerNumberBox(data[2])),
          ),
          Expanded(
            flex: 1,
            child: Center(child: ResultInnerNumberBox(data[3])),
          ),
          Expanded(
            flex: 1,
            child: Center(child: ResultInnerNumberBox(data[4])),
          ),
        ],
      ),
    );
  }
}
