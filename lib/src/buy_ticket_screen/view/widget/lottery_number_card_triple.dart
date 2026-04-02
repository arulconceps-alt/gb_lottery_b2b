import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryNumberCardTriple extends StatefulWidget {
  final double Function(double) s;
  final String lotteryType;
  final String prize;
  final String ticketPrice;
  final List<String> letters;
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
  int quantity = 1;

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
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.lotteryType,
                  style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(12), fontWeight: FontWeight.w500)),
              SizedBox(width: s(8)),
              Text(widget.prize,
                  style: GoogleFonts.dmSans(color: const Color(0xFFCFB95D), fontSize: s(12), fontWeight: FontWeight.w500)),
              const Spacer(),
              _quickGuessButton(s),
            ],
          ),
          SizedBox(height: s(3)),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '₹ ',
                    style: GoogleFonts.dmSans(color: const Color(0xFFDFC45C), fontSize: s(11), fontWeight: FontWeight.w500)),
                TextSpan(text: widget.ticketPrice.replaceAll(RegExp(r'[^0-9.]'), ''),
                    style: GoogleFonts.dmSans(color: const Color(0xFFDFC45C), fontSize: s(12), fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          SizedBox(height: s(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: widget.letters.asMap().entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(right: entry.key == widget.letters.length - 1 ? 0 : s(10)),
                    child: _box(entry.value, s),
                  );
                }).toList(),
              ),
              Row(
                children: dashValues.asMap().entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(left: entry.key == 0 ? 0 : s(12)),
                    child: _box(entry.value, s),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: s(12)),

          // Bottom Action Row - Clean Row implementation
          SizedBox(
            height: s(36),
            child: Row(
              children: [
                if (isQuickGuessClicked)
                  _quantitySelector(s),

                const Spacer(),

                // BOX Button
                isQuickGuessClicked
                    ? _goldActionButton(
                  text: "Box",
                  width: 68,
                  s: s,
                  onTap: () => widget.onAdd(widget.letters.join(), dashValues.join(), true, quantity, pricePerUnit),
                )
                    : _greyButton("Box", 68, s),

                SizedBox(width: s(10)),

                // ADD Button
                isQuickGuessClicked
                    ? _goldActionButton(
                  text: "Add",
                  width: 68,
                  s: s,
                  onTap: () => widget.onAdd(widget.letters.join(), dashValues.join(), false, quantity, pricePerUnit),
                )
                    : _greyButton("Add", 68, s),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _box(String text, double Function(double) s) {
    return Container(
      width: s(36), height: s(36),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(s(6)),
      ),
      child: Text(text,
          style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(14), fontWeight: FontWeight.w500)),
    );
  }

  Widget _quickGuessButton(double Function(double) s) {
    return GestureDetector(
      onTap: _fillRandom,
      child: Container(
        width: s(92), height: s(32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF313038),
          borderRadius: BorderRadius.circular(s(6)),
        ),
        child: Text('Quick Guess',
            style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(12))),
      ),
    );
  }

  Widget _quantitySelector(double Function(double) s) {
    return Container(
      width: s(92), height: s(36),
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(s(6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => quantity = max(1, quantity - 1)),
            child: Text("-", style: TextStyle(color: Colors.white, fontSize: s(18))),
          ),
          Text("$quantity",
              style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(14), fontWeight: FontWeight.bold)),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => quantity++),
            child: Text("+", style: TextStyle(color: Colors.white, fontSize: s(18))),
          ),
        ],
      ),
    );
  }

  Widget _goldActionButton({
    required String text,
    required double width,
    required double Function(double) s,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: s(68), height: s(36),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)]),
          borderRadius: BorderRadius.circular(s(6)),
        ),
        child: Text(text,
            style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(14), fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _greyButton(String text, double width, double Function(double) s) {
    return Container(
      width: s(width), height: s(36),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(s(6)),
      ),
      child: Text(text,
          style: GoogleFonts.dmSans(color: Colors.white.withOpacity(0.4), fontSize: s(14))),
    );
  }
}