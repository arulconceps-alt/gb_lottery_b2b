import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRadioItem extends StatelessWidget {
  final String text;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const CustomRadioItem({
    super.key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: s(18),
            width: s(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? ColorPalette.primary
                    : ColorPalette.whitetext,
                width: 1.5,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      height: s(8),
                      width: s(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.primary,
                      ),
                    ),
                  )
                : null,
          ),

          SizedBox(width: s(10)),

          /// 🔹 TEXT
          Text(
            text,
            style: GoogleFonts.dmSans(
              fontSize: s(16),
              fontWeight: FontWeight.w400,
              color: ColorPalette.whitetext,
            ),
          ),
        ],
      ),
    );
  }
}

class UserTypeSelector extends StatefulWidget {
  const UserTypeSelector({super.key});

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  String selectedValue = "all";

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Row(
      children: [
        CustomRadioItem(
          text: "All",
          value: "all",
          groupValue: selectedValue,
          onChanged: (val) {
            setState(() => selectedValue = val);
          },
        ),

        SizedBox(width: s(20)),

        CustomRadioItem(
          text: "Customer",
          value: "customer",
          groupValue: selectedValue,
          onChanged: (val) {
            setState(() => selectedValue = val);
          },
        ),

        SizedBox(width: s(20)),

        CustomRadioItem(
          text: "Moderator",
          value: "moderator",
          groupValue: selectedValue,
          onChanged: (val) {
            setState(() => selectedValue = val);
          },
        ),
      ],
    );
  }
}