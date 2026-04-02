import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseHistoryListItem extends StatelessWidget {
  final double Function(double) s;

  const PurchaseHistoryListItem({
    super.key,
    required this.s,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: s(92),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
      //  borderRadius: BorderRadius.circular(s(10)),
      ),
      child: Row(
        children: [
          SizedBox(width: s(16)),

          /// LEFT IMAGE
          Container(
            width: s(60),
            height: s(60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(s(10)),
              image: const DecorationImage(
                image: AssetImage(
                  "assets/images/myCart/list_image.webp",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: s(12)),

          /// CENTER TEXT
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kerala Lottery , ABC",
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(16),
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),

                SizedBox(height: s(6)),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Customer name : ",
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFF9F9F9F),
                          fontSize: s(10),
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                        ),
                      ),
                      TextSpan(
                        text: "Baranee",
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: s(10),
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: s(2)),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Phone number : ",
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFF9F9F9F),
                          fontSize: s(10),
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                        ),
                      ),
                      TextSpan(
                        text: "9874563215",
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: s(10),
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// RIGHT ARROW
          /// RIGHT ARROW / LIST IMAGE SECTION
          Padding(
            padding: EdgeInsets.only(right: s(16)), // Distance from right edge
            child: Container(
              width: s(20),  // Figma Width: 20px
              height: s(20), // Figma Height: 20px
              alignment: Alignment.center, // Centers the 5.5px icon inside the 20px box
              child: Image.asset(
                "assets/images/purchase_history_list/right_arrow_icon.webp",
                width: s(20),  // Figma Width: 20px
                height: s(20), // Figma Icon Height: 11.25px
                color: Colors.white,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}