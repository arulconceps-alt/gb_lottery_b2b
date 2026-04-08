import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCustomerFormSection extends StatefulWidget {
  final ScrollController controller;

  const AddCustomerFormSection({super.key, required this.controller});

  @override
  State<AddCustomerFormSection> createState() => _AddCustomerFormSectionState();
}

class _AddCustomerFormSectionState extends State<AddCustomerFormSection> {
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
            // REMOVED the Column with _addButton from here
            return _buildForm(s, index);
          },
        ),
        // Put it here so it only appears once at the bottom of the list
        _addButton(s),
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
          "assets/images/add_customer/add.png",
          height: s(50),
          width: s(50),
        ),
      ),
    );
  }

  Widget _buildForm(double Function(double) s, int index) {
    bool isExpanded = expandedList[index];

    return Stack(
      clipBehavior: Clip.none, // Allows the icon to overlap the border
      children: [
        // 1. Your existing Container
        Container(
          margin: EdgeInsets.only(bottom: s(16)),
          decoration: BoxDecoration(
            color: ColorPalette.backgroundDark,
            borderRadius: BorderRadius.circular(s(8)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(s(15)),
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
                  ],
                ),
              ),
              SizedBox(height: s(10)),
              GestureDetector(
                onTap: () => setState(() => expandedList[index] = !expandedList[index]),
                child: Container(
                  height: s(40),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF313038),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(s(8)),
                      bottomRight: Radius.circular(s(8)),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        isExpanded ? "View Less" : "View More",
                        style: GoogleFonts.dmSans(
                          color: ColorPalette.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: s(16),
                        ),
                      ),
                      Positioned(
                        right: s(10),
                        child: Image.asset(
                          "assets/images/add_customer/down_arrow.png",
                          height: s(16),
                          width: s(16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. The Overlapping Cross Button (Hidden for index 0)
        if (index != 0)
          Positioned(
            top: -s(6),  // Move slightly above the container
            right: -s(0), // Move slightly outside to the right
            child: GestureDetector(
              onTap: () {
                setState(() {
                  expandedList.removeAt(index);
                });
              },
              child: Container(
                width: s(20),
                height: (20),
                decoration: BoxDecoration(
                   color: Color(0xFFD9D9D9),
                  shape: BoxShape.circle
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    "assets/images/add_customer/cross.png",
                    width: s(11),
                  height: (11),
                  color: Colors.black,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
  Widget _field(String hint, double Function(double) s, {int maxLines = 1}) {
    return Container(
      height: maxLines == 1 ? s(48) : s(87),
      //padding: EdgeInsets.symmetric(horizontal: s(17), vertical: s(14)),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E24),
        borderRadius: BorderRadius.circular(s(10)),
      ),
     alignment: maxLines > 1
    ? Alignment.centerLeft
    : Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: s(17),),
        child: TextField(
          maxLines: maxLines,
            style: GoogleFonts.dmSans(
              color: ColorPalette.whitetext,
              fontWeight: FontWeight.w400,
              fontSize: s(14),
            ),
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
