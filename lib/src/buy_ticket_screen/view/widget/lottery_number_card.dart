import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryNumberCard extends StatefulWidget {
  final double Function(double) s;
  final List<String> letters;
  final String prize;
  final String ticketPrice;
  final String gameType;

  // FIX: Change this line to match 4 parameters
  final Function(String letter, String value, int count, double pricePerUnit)
  onAdd;

  const LotteryNumberCard({
    super.key,
    this.letters = const ["A", "B", "C"],
    this.prize = "Win ₹1000.00",
    this.ticketPrice = "₹10",
    this.gameType = "Single Digit",
    required this.s,
    required this.onAdd, // The bridge to the footer
  });

  @override
  State<LotteryNumberCard> createState() => _LotteryNumberCardState();
}

class _LotteryNumberCardState extends State<LotteryNumberCard> {
  late List<String> dashValues;
  late List<int> quantities;
  bool isQuickGuessClicked = false;

  @override
  void initState() {
    super.initState();
    dashValues = List.generate(widget.letters.length, (_) => "-");
    quantities = List.generate(widget.letters.length, (_) => 1);
  }

  void fillRandomDashes() {
    final random = Random();
    setState(() {
      isQuickGuessClicked = true;
      for (int i = 0; i < dashValues.length; i++) {
        dashValues[i] = random.nextInt(10).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.s;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: s(62),
                height: s(16.44), // Figma: Fixed (16.4444px)
                child: Text(
                  widget.gameType,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(12),         // Figma: Size 12px
                    fontWeight: FontWeight.w500, // Figma: Weight 500 (Medium)
                    fontStyle: FontStyle.normal, // Figma: Regular (Not italic)
                    height: 1.30,            // Figma: Line height 130%
                    letterSpacing: s(-0.12), // Figma: -1% (-0.01 * 12)
                  ),
                ),
              ),
               SizedBox(width: s(6)),
              SizedBox(
                width: s(78),
                height: s(18.5),
                child: Text(
                  widget.prize,
                  maxLines: 1,
                  // This prevents system font scaling from breaking your fixed height
                  textScaler: TextScaler.noScaling,
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFFCFB95D),
                    fontSize: s(11),
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                    letterSpacing: s(-0.11),
                  ),
                ),
              ),
              const Spacer(),
              _quickGuessButton(),
            ],
          ),
          SizedBox(height:s(2.06) ,),
          Text(
            widget.ticketPrice,
            style: const TextStyle(color: Color(0xFF9F9F9F), fontSize: 12),
          ),
          const SizedBox(height: 16),
          ...List.generate(widget.letters.length, (index) => _buildRow(index)),
        ],
      ),
    );
  }

  Widget _buildRow(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          _letterBox(widget.letters[index]),
          const SizedBox(width: 10),
          _letterBox(dashValues[index]),
          const Spacer(),
          if (isQuickGuessClicked) ...[
            _quantitySelector(index),
            const SizedBox(width: 8),
            _goldAddButton(index),
          ] else ...[
            _greyAddButton(),
          ],
        ],
      ),
    );
  }

  Widget _goldAddButton(int index) {
    return GestureDetector(
      onTap: () {
        if (dashValues[index] == "-")
          return; // Prevent adding if no number selected

        double price =
            double.tryParse(widget.ticketPrice.replaceAll('₹', '')) ?? 0.0;

        // Pass specific details back to the Screen
        widget.onAdd(
          widget.letters[index],
          dashValues[index],
          quantities[index],
          price,
        );
      },
      child: Container(
        width: 44,
        height: 36,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          "Add",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _letterBox(String text) => Container(
    width: 36,
    height: 36,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xFF313038),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(text, style: const TextStyle(color: Colors.white)),
  );

  Widget _quickGuessButton() => GestureDetector(
    onTap: fillRandomDashes,
    child: Container(
      // Figma: Width Fixed (92px), Height Fixed (32px)
      width: widget.s(92),
      height: widget.s(32),
      alignment: Alignment.center, // Figma: Vertical alignment Middle
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        // Figma: Radius 6px
        borderRadius: BorderRadius.circular(widget.s(6)),
      ),
      child: SizedBox(
        // Figma: Font Width Fixed (69px), Height Fixed (16.92px)
        width: widget.s(69),
        height: widget.s(16.9262),
        child: Text(
          'Quick Guess',
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
            color: Colors.white,
            // Figma: Size 12px
            fontSize: widget.s(12),
            // Figma: Weight 400 (Regular)
            fontWeight: FontWeight.w400,
            // Figma: Line height 130%
            height: 1.30,
            // Figma: Letter spacing -1% (12 * -0.01 = -0.12)
            letterSpacing: widget.s(-0.12),
          ),
        ),
      ),
    ),
  );

  Widget _greyAddButton() => Container(
    height: 36,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xFF313038),
      borderRadius: BorderRadius.circular(6),
    ),
    child: const Text("Add", style: TextStyle(color: Colors.white)),
  );

  Widget _quantitySelector(int index) => Container(
    width: 92,
    height: 36,
    decoration: BoxDecoration(
      color: const Color(0xFF313038),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () =>
              setState(() => quantities[index] = max(1, quantities[index] - 1)),
          child: const Text(
            "-",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Text(
          "${quantities[index]}",
          style: const TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () => setState(() => quantities[index]++),
          child: const Text(
            "+",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    ),
  );
}
