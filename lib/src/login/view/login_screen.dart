import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 360;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1B20),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: s(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: s(145)),
              Image.asset(
                "assets/images/login/otp.webp",
                height: s(87),
                width: s(82),
              ),

              SizedBox(height: s(25)),

              Text(
                "Just Verify & Play",
                style: GoogleFonts.inter(
                  fontSize: s(17),
                  fontWeight: FontWeight.w700,
                  color: ColorPalette.whitetext,
                ),
              ),

              SizedBox(height: s(10)),

              Text(
                "Lorem Ipsum has been the industry's\nstandard dummy text ever since the 1500s",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: s(14),
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.whitetext,
                ),
              ),

              SizedBox(height: s(32)),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: s(66),
                    width: s(326),
                    padding: EdgeInsets.symmetric(
                      horizontal: s(31),
                      vertical: s(23),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(s(10)),
                      border: Border.all(
                        color: ColorPalette.whitetext.withOpacity(0.3),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "+91 9874563210",
                      style: GoogleFonts.inter(
                        fontSize: s(14),
                        color: ColorPalette.whitetext,
                      ),
                    ),
                  ),
                  Positioned(
                    left: s(14),
                    top: -s(8),
                    child: Container(
                      height: s(24),
                      padding: EdgeInsets.symmetric(vertical:  s(2), horizontal: s(6)),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: ColorPalette.surface,
                    ),
                     
                      child: Text(
                        "Mobile Number",
                        maxLines: 1,
                        style: GoogleFonts.inter(
                          fontSize: s(14),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.whitetext,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: s(10)),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "You will receive an OTP for Verification",
                  style: GoogleFonts.inter(
                    fontSize: s(14),
                    fontWeight: FontWeight.w400,
                   color: ColorPalette.whitetext,
                  ),
                ),
              ),

              SizedBox(height: s(50.3)),

              Row(
                children: [
                  Container(
                    height: s(19.77),
                    width: s(19.77),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all( color: ColorPalette.whitetext,),
                    ),
                    child: Icon(Icons.check, size: s(14),  color: ColorPalette.whitetext,),
                  ),

                  SizedBox(width: s(10)),

                  Expanded(
                    child: Text(
                      "I certify that I am 18 years years old",
                      style: GoogleFonts.inter(
                        fontSize: s(14),
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.whitetext,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: s(13)),

              GestureDetector(
                onTap: (){
                  context.push('/otp');
                },
                child: Container(
                  height: s(50),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(s(12)),
                   gradient: ColorPalette.buttonGradient
                  ),
                  child: Text(
                    "Register",
                    style: GoogleFonts.inter(
                      fontSize: s(16),
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.whitetext,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
