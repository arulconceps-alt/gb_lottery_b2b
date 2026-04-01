import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCustomerFormSection extends StatefulWidget {
  final ScrollController controller;

  const AddCustomerFormSection({super.key, required this.controller});

  @override
  State<AddCustomerFormSection> createState() =>
      _AddCustomerFormSectionState();
}

class _AddCustomerFormSectionState
    extends State<AddCustomerFormSection> {
  List<bool> expandedList = [false];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: expandedList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                _buildForm(s, index),
                _addButton(s),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _addButton(double Function(double) s) {
    return Padding(
      padding: EdgeInsets.only(bottom: s(16)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            expandedList.add(false);
          });

          Future.delayed(const Duration(milliseconds: 300), () {
            widget.controller.animateTo(
              widget.controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
          });
        },
        child: Image.asset(
                "assets/images/add_customer/add.webp", 
                height: s(50),
                width: s(50),
              ),
      ),
    );
  }

  

  Widget _buildForm(double Function(double) s, int index) {
    bool isExpanded = expandedList[index];

    return Container(
      height: isExpanded ? s(400) : s(244), 
      margin: EdgeInsets.only(bottom: s(16)),
      padding: EdgeInsets.all(s(12)),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(s(12)),
      ),
      child: Column(
        children: [
          _field("Enter Name*", s),

          SizedBox(height: s(11)),
          _field("Enter Phone Number*", s),

          SizedBox(height: s(11)),
          _field("Enter Pincode*", s),

          if (isExpanded) ...[
            SizedBox(height: s(11)),
            _field("Enter Email", s),

            SizedBox(height: s(11)),
            _field("Enter Address", s, maxLines: 3),
          ],

          SizedBox(height: s(10)),

          GestureDetector(
            onTap: () {
              setState(() {
                expandedList[index] = !expandedList[index];
              });
            },
            child: Container(
              height: s(40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF313038),
                borderRadius: BorderRadius.circular(s(8)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "More",
                    style: GoogleFonts.dmSans(
                      color: ColorPalette.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: s(16),
                    ),
                  ),
                  Positioned(
                    right: s(10),
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: ColorPalette.primary,
                      size: s(16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String hint, double Function(double) s,
      {int maxLines = 1}) {
    return Container(
      height: maxLines == 1 ? s(48) : s(87),
      padding: EdgeInsets.symmetric(horizontal: s(12)),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E24),
        borderRadius: BorderRadius.circular(s(8)),
      ),
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: s(17),
          vertical: s(14),
        ),
        child: TextField(
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.dmSans(
              color: ColorPalette.darktext,
              fontWeight: FontWeight.w400,
              fontSize: s(14),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}