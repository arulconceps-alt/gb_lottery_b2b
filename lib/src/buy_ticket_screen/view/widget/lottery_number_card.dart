import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryNumberCard extends StatefulWidget {
  final double Function(double) s;
  final List<String> letters;
  final String prize;
  final String ticketPrice;
  final String gameType;
  final Function(String letter, String value, int count, double pricePerUnit) onAdd;

  const LotteryNumberCard({
    super.key,
    this.letters = const ["A", "B", "C"],
    this.prize = "Win ₹1000.00",
    this.ticketPrice = "₹10.00",
    this.gameType = "Single Digit",
    required this.s,
    required this.onAdd,
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
      padding: EdgeInsets.all(s(12)), // Scaled padding
      decoration: BoxDecoration(
        color:  ColorPalette.backgroundDark,
        borderRadius: BorderRadius.circular(s(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: s(62),
                height: s(16.44),
                child: Text(
                  widget.gameType,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: s(12),
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                    letterSpacing: s(-0.12),
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
              _quickGuessButton(s),
            ],
          ),

          SizedBox(height: s(3)), // Exact 3px space

          // Price Section
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '₹ ',
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFFDFC45C),
                    fontSize: s(11),
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
                TextSpan(
                  text: widget.ticketPrice.replaceAll(RegExp(r'[^0-9.]'), ''),
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFFDFC45C),
                    fontSize: s(12),
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: s(16)),

          // Selection Rows
          ...List.generate(widget.letters.length, (index) => _buildRow(index, s)),
        ],
      ),
    );
  }

  Widget _buildRow(int index, double Function(double) s) {
    return Padding(
      padding: EdgeInsets.only(bottom: s(10)),
      child: Row(
        children: [
          _box(widget.letters[index], s),
          SizedBox(width: s(10)),
          _box(dashValues[index], s),
          const Spacer(),
          if (isQuickGuessClicked) ...[
            _quantitySelector(index, s),
            SizedBox(width: s(8)),
            _goldAddButton(index, s),
          ] else ...[
            _greyAddButton(s),
          ],
        ],
      ),
    );
  }

  Widget _box(String text, double Function(double) s) {
    return Container(
      width: s(36),
      height: s(36),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(s(6)),
      ),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: s(14),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _quickGuessButton(double Function(double) s) {
    return GestureDetector(
      onTap: fillRandomDashes,
      child: Container(
        width: s(92),
        height: s(32),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF313038),
          borderRadius: BorderRadius.circular(s(6)),
        ),
        child: SizedBox(
          width: s(69),
          height: s(16.92),
          child: Text(
            'Quick Guess',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: s(12),
              fontWeight: FontWeight.w400,
              height: 1.30,
              letterSpacing: s(-0.12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _quantitySelector(int index, double Function(double) s) {
    return Container(
      width: s(92),
      height: s(36),
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(s(6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => setState(() => quantities[index] = max(1, quantities[index] - 1)),
            child: Text("-", style: TextStyle(color: Colors.white, fontSize: s(18))),
          ),
          Text("${quantities[index]}", style: TextStyle(color: Colors.white, fontSize: s(14))),
          GestureDetector(
            onTap: () => setState(() => quantities[index]++),
            child: Text("+", style: TextStyle(color: Colors.white, fontSize: s(18))),
          ),
        ],
      ),
    );
  }

  Widget _goldAddButton(int index, double Function(double) s) {
    return GestureDetector(
      onTap: () {
        if (dashValues[index] == "-") return;
        double price = double.tryParse(widget.ticketPrice.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
        widget.onAdd(widget.letters[index], dashValues[index], quantities[index], price);
      },
      child: Container(
        width: s(44),
        height: s(36),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
          ),
          borderRadius: BorderRadius.circular(s(6)),
        ),
        child: Text(
          "Add",
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontSize: s(14),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _greyAddButton(double Function(double) s) {
    return Container(
      height: s(36),
      padding: EdgeInsets.symmetric(horizontal: s(12)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(s(6)),
      ),
      child: Text(
        "Add",
        style: GoogleFonts.dmSans(
          color: Colors.white.withOpacity(0.5),
          fontSize: s(14),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}