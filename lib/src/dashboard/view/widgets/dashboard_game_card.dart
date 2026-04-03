import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardGameCard extends StatelessWidget {
  final String image;
  final String title;
  final String prize;

  const DashboardGameCard({
    super.key,
    required this.image,
    required this.title,
    required this.prize,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Container(
      width: s(167),
      height: s(160),
      padding: EdgeInsets.all(s(10)),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2B33),
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: s(50),
                width: s(50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: s(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.dmSans(
                        fontSize: s(12),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: ColorPalette.whitetext,
                      ),
                    ),
                     SizedBox(height: s(1)),
                    Text(
                      "Win Price",
                      style: GoogleFonts.dmSans(
                        fontSize: s(12),
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.darktext,
                      ),
                    ),
                     SizedBox(height: s(1)),
                    Text(
                      prize,
                      style: GoogleFonts.dmSans(
                        fontSize: s(12),
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.whitetext,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: s(8)),
          Text(
            "Next draw starts in :",
            style: GoogleFonts.dmSans(
              fontSize: s(10),
              fontWeight: FontWeight.w400,
              color: ColorPalette.darktext,
            ),
          ),

          SizedBox(height: s(4)),
          Row(
            children: [
              _timeBox("01h", s),
              SizedBox(width: s(3)),
              Text(
                ":",
                style: GoogleFonts.dmSans(
                  fontSize: s(12),
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.whitetext,
                ),
              ),
              SizedBox(width: s(5)),
              _timeBox("01m", s),
              SizedBox(width: s(3)),
              Text(
                ":",
                style: GoogleFonts.dmSans(
                  fontSize: s(12),
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.whitetext,
                ),
              ),
              SizedBox(width: s(5)),
              _timeBox("30s", s),
            ],
          ),

           SizedBox(height: s(8)),

          GestureDetector(
            onTap: () => context.push('/buy_ticket'),
            child: Container(
              width: double.infinity,
              height: s(34),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorPalette.surface,
                borderRadius: BorderRadius.circular(s(6)),
              ),
              child: Text(
                "Play Now",
                style: GoogleFonts.dmSans(
                  fontSize: s(12),
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.whitetext,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeBox(String text, double Function(double) s) {
    return Container(
      width: s(40),
      height: s(18),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorPalette.surface,
        borderRadius: BorderRadius.circular(s(4)),
      ),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: s(10),
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
          color: ColorPalette.whitetext,
        ),
      ),
    );
  }
}
