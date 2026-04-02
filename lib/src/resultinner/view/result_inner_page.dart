import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_text_with_back.dart';
import 'package:gb_lottery_b2b/src/common/widgets/custom_drawer.dart';
import 'package:gb_lottery_b2b/src/resultinner/view/widgets/resluts_inner_lottry_section_card.dart';

class ResultInnerPage extends StatefulWidget {
  const ResultInnerPage({super.key});

  @override
  State<ResultInnerPage> createState() => _ResultInnerPageState();
}

class _ResultInnerPageState extends State<ResultInnerPage> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
     final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    return Scaffold(
     key: _scaffoldKey,
      drawer: const CustomDrawer(),
        backgroundColor: const Color(0xFF1C1B20),
      appBar: AppBarTextWithBack(title: "ABC Game"),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: s(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: s(17)),
              ResultsInnerLottrySectionCard(title: "Kerala Lottry"),
               
            ],
          ),
        ),
      )
    );
  }
}