import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCustomerSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const AddCustomerSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Center(
      child: Container(
        width: s(344), 
        height: s(123), 
        padding: EdgeInsets.all(s(12)), 
        decoration: BoxDecoration(
          color: const Color(0xFF2C2B33),
          borderRadius: BorderRadius.circular(s(8)), 
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: (15)), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.dmSans(
                        fontSize: s(16), 
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.whitetext,
                      ),
                    ),
                    SizedBox(height: s(9)),
                    Text(
                      subtitle,
                      style: GoogleFonts.dmSans(
                        fontSize: s(14), 
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.darktext,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: s(10)), 

            Padding(
               padding: EdgeInsets.all(s(20)), 
              child: Container(
                height: s(70),
                width: s(70), 
                 padding: EdgeInsets.all(s(17)),  
                decoration: BoxDecoration(
                  gradient: ColorPalette.buttonGradient,
                  borderRadius: BorderRadius.circular(s(14)), 
                ),
                child: Image.asset(
                  "assets/images/dashboard/add_cus.webp",
                  height: s(35), 
                  width: s(35),  
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}