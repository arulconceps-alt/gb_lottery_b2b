import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/add_customer/view/widgets/add_customer_form_section.dart';
import 'package:gb_lottery_b2b/src/add_customer/view/widgets/add_customer_radio_button.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/widgets/app_bar_with_back.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final ScrollController _pageController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1E26),
      appBar: AppBarWithBack(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
        child: _doneButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: s(20)),
        child: SingleChildScrollView(
          controller: _pageController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: s(28)),

              Text(
                "Select Customer or Moderator",
                style: GoogleFonts.inter(
                  fontSize: s(18),
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: ColorPalette.whitetext,
                ),
              ),

              SizedBox(height: s(21)),

              AddCustomerTypeSelector(),

              SizedBox(height: s(24)),

              AddCustomerFormSection(controller: _pageController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _doneButton() {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Container(
      width: double.infinity,
      height: s(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(s(10)),
        gradient: ColorPalette.buttonGradient,
      ),
      child: Center(
        child: Text(
          "Done",
          style: GoogleFonts.dmSans(
            fontSize: s(16),
            fontWeight: FontWeight.w700,
            color: ColorPalette.whitetext,
          ),
        ),
      ),
    );
  }
}
