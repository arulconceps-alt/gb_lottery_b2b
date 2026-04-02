import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryNumberCardTriple extends StatefulWidget {
  final double Function(double) s;
  final String lotteryType;
  final String prize;
  final String ticketPrice;
  final List<String> letters;
  // Updated callback to include quantity and price
  final Function(String label, String value, bool isBox, int count, double price) onAdd;

  const LotteryNumberCardTriple({
    super.key,
    required this.s,
    this.lotteryType = "Triple Digit",
    this.prize = "Win ₹20000.00",
    this.ticketPrice = "₹100.00",
    this.letters = const ["A", "B", "C"],
    required this.onAdd,
  });

  @override
  State<LotteryNumberCardTriple> createState() => _LotteryNumberCardTripleState();
}

class _LotteryNumberCardTripleState extends State<LotteryNumberCardTriple> {
  List<String> dashValues = ["-", "-", "-"];
  bool isQuickGuessClicked = false;
  int quantity = 1; // Track quantity

  void _fillRandom() {
    final random = Random();
    setState(() {
      isQuickGuessClicked = true;
      dashValues = List.generate(3, (_) => random.nextInt(10).toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.s;
    double pricePerUnit = double.tryParse(widget.ticketPrice.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s(12)),
      decoration: BoxDecoration(
        color:  ColorPalette.backgroundDark,
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Text(widget.lotteryType, style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(12), fontWeight: FontWeight.w500)),
              SizedBox(width: s(8)),
              Text(widget.prize, style: GoogleFonts.dmSans(color: const Color(0xFFCFB95D), fontSize: s(12), fontWeight: FontWeight.w500)),
              const Spacer(),
              _quickGuessButton(s),
            ],
          ),

          SizedBox(height: s(3)),

          // Price Row
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '₹ ', style: GoogleFonts.dmSans(color: const Color(0xFFDFC45C), fontSize: s(11), fontWeight: FontWeight.w500)),
                TextSpan(text: widget.ticketPrice.replaceAll(RegExp(r'[^0-9.]'), ''), style: GoogleFonts.dmSans(color: const Color(0xFFDFC45C), fontSize: s(12), fontWeight: FontWeight.w500)),
              ],
            ),
          ),

          SizedBox(height: s(16)),

          // Numbers Row
          // Numbers Row
          Row(
            children: [
              // Left side: A, B, C boxes
              ...widget.letters.asMap().entries.map((entry) {
                int idx = entry.key;
                String label = entry.value;
                return Padding(
                  // Add right padding ONLY if it's NOT the last letter box
                  padding: EdgeInsets.only(right: idx == widget.letters.length - 1 ? 0 : s(10)),
                  child: _box(label, s),
                );
              }),

              const Spacer(),

              // Right side: Digit boxes (the dash/random values)
              ...dashValues.asMap().entries.map((entry) {
                int idx = entry.key;
                String val = entry.value;
                return Padding(
                  // Add left padding ONLY if it's NOT the first digit box
                  // This ensures the last box (idx 2) has 0 right padding and hits the edge
                  padding: EdgeInsets.only(left: idx == 0 ? 0 : s(12)),
                  child: _box(val, s),
                );
              }),
            ],
          ),

          SizedBox(height: s(12)),

          // Bottom Action Row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isQuickGuessClicked) ...[
                _quantitySelector(s),
                SizedBox(width: s(10)),
                _goldActionButton(text: "Box", width: 68, s: s, isBox: true, price: pricePerUnit),
                SizedBox(width: s(10)),
                _goldActionButton(text: "Add", width: 68, s: s, isBox: false, price: pricePerUnit),
              ] else ...[
                // Default greyed out buttons when not clicked
                _greyButton("Box", 68, s),
                SizedBox(width: s(10)),
                _greyButton("Add", 68, s),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _box(String text, double Function(double) s) {
    return Container(
      width: s(36), height: s(36),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: const Color(0xFF313038), borderRadius: BorderRadius.circular(s(6))),
      child: Text(text, style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(14), fontWeight: FontWeight.w500)),
    );
  }

  Widget _quickGuessButton(double Function(double) s) {
    return GestureDetector(
      onTap: _fillRandom,
      child: Container(
        width: s(92), height: s(32),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: const Color(0xFF313038), borderRadius: BorderRadius.circular(s(6))),
        child: Text('Quick Guess', style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(12))),
      ),
    );
  }

  Widget _quantitySelector(double Function(double) s) {
    return Container(
      width: s(92), height: s(36),
      decoration: BoxDecoration(color: const Color(0xFF313038), borderRadius: BorderRadius.circular(s(6))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(onTap: () => setState(() => quantity = max(1, quantity - 1)), child: Text("-", style: TextStyle(color: Colors.white, fontSize: s(18)))),
          Text("$quantity", style: TextStyle(color: Colors.white, fontSize: s(14))),
          GestureDetector(onTap: () => setState(() => quantity++), child: Text("+", style: TextStyle(color: Colors.white, fontSize: s(18)))),
        ],
      ),
    );
  }

  Widget _goldActionButton({required String text, required double width, required double Function(double) s, required bool isBox, required double price}) {
    return GestureDetector(
      onTap: () => widget.onAdd(widget.letters.join(), dashValues.join(), isBox, quantity, price),
      child: Container(
        width: s(width), height: s(36),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)]),
          borderRadius: BorderRadius.circular(s(6)),
        ),
        child: Text(text, style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(14), fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _greyButton(String text, double width, double Function(double) s) {
    return Container(
      width: s(width), height: s(36),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: const Color(0xFF313038), borderRadius: BorderRadius.circular(s(6))),
      child: Text(text, style: GoogleFonts.dmSans(color: Colors.white.withOpacity(0.4), fontSize: s(14))),
    );
  }
}