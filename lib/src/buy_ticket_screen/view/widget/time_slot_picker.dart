import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeSlotPicker extends StatefulWidget {
  final double Function(double) s;
  final List<String> slots;
  final Function(String) onSelectionChanged;

  const TimeSlotPicker({
    super.key,
    required this.s,
    required this.slots,
    required this.onSelectionChanged,
  });

  @override
  State<TimeSlotPicker> createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimeSlotPicker> {
  String? selectedSlot;

  @override
  void initState() {
    super.initState();
    if (widget.slots.isNotEmpty) {
      selectedSlot = widget.slots.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.s(60),
      padding: EdgeInsets.only(
        left: widget.s(16),
        right: widget.s(12),
        top: widget.s(12),
        bottom: widget.s(12),
      ),
      color: const Color(0xFF1B1A1F), // ✅ background like design
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.slots.length,
        separatorBuilder: (_, __) => SizedBox(width: widget.s(10)), // ✅ gap 10
        itemBuilder: (context, index) {
          final time = widget.slots[index];
          final isSelected = selectedSlot == time;

          return GestureDetector(
            onTap: () {
              setState(() => selectedSlot = time);
              widget.onSelectionChanged(time);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.s(14),
                vertical: widget.s(9),
              ),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                  begin: Alignment.centerRight, // ✅ match your first widget
                  end: Alignment.centerLeft,
                  colors: [
                    Color(0xFFDFC45C),
                    Color(0xFFA89A5F),
                  ],
                )
                    : null,
                color: isSelected ? null : const Color(0xFF24232A),
                borderRadius: BorderRadius.circular(widget.s(8)),
              ),
              child: Center(
                child: Text(
                  time,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: widget.s(14),
                    fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w500,
                    height: 1.3,
                    letterSpacing: widget.s(-0.14),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}