import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateFilterBottomSheet extends StatefulWidget {
  const DateFilterBottomSheet({super.key});

  @override
  State<DateFilterBottomSheet> createState() =>
      _DateFilterBottomSheetState();
}

class _DateFilterBottomSheetState
    extends State<DateFilterBottomSheet> {
  String selected = "This Month";

  final options = [
    "This Month",
    "Last 60 days",
    "Last 90 days",
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Container(
      padding: EdgeInsets.fromLTRB(
        s(20),
        s(20),
        s(20),
        s(16),
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF24232A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Title + close
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date",
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    "assets/images/wallet/cross_icon.png",
                    height: s(16),
                    width: s(16),
                  ),
                ),
              ],
            ),

            SizedBox(height: s(16)),

            ...options.map((item) {
              final isSelected = selected == item;
              return Padding(
                padding: EdgeInsets.only(bottom: s(16),right: s(1)),
                child: GestureDetector(
                  onTap: () => setState(() => selected = item),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item,
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: s(18),
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                      ),
                      _buildRadioCircle(s, isSelected),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: s(9)),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: s(335),
                height: s(32),
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Color(0xFFDFC45C),
                      Color(0xFFA89A5F),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(s(8)),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Apply',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(16),
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                    letterSpacing: -0.16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioCircle(
      double Function(double) s,
      bool isSelected,
      ) {
    return Container(
      width: s(18),
      height: s(18),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? const Color(0xFFDFC45C)
            : const Color(0xFFD9D9D9),
      ),
      child: Center(
        child: Container(
          width: s(14),
          height: s(14),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF24232A),
          ),
          child: isSelected
              ? Center(
            child: Container(
              width: s(8),
              height: s(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFDFC45C),
              ),
            ),
          )
              : null,
        ),
      ),
    );
  }
}