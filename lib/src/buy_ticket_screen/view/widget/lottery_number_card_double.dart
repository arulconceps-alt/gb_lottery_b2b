import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LotteryNumberCardDouble extends StatefulWidget {
  final double Function(double) s;
  final String lotteryType;
  final String prize;
  final String ticketPrice;
  final List<List<String>> rows;
  final Function(String letter, String value, int count, double pricePerUnit) onAdd;

  const LotteryNumberCardDouble({
    super.key,
    required this.s,
    this.lotteryType = "Double Digit",
    this.prize = "Win ₹1000.00",
    this.ticketPrice = "₹100.00",
    required this.onAdd,
    this.rows = const [
      ["A", "B"],
      ["A", "C"],
      ["B", "C"],
    ],
  });

  @override
  State<LotteryNumberCardDouble> createState() => _LotteryNumberCardDoubleState();
}

class _LotteryNumberCardDoubleState extends State<LotteryNumberCardDouble> {
  late List<List<String>> dashValues;
  late List<int> quantities;
  bool isQuickGuessClicked = false;

  @override
  void initState() {
    super.initState();
    dashValues = List.generate(widget.rows.length, (_) => ["-", "-"]);
    quantities = List.generate(widget.rows.length, (_) => 1);
  }

  void fillRandomDashes() {
    final random = Random();
    setState(() {
      isQuickGuessClicked = true;
      for (int i = 0; i < dashValues.length; i++) {
        dashValues[i][0] = random.nextInt(10).toString();
        dashValues[i][1] = random.nextInt(10).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.s;

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
          // Header Row
          Row(
            children: [
              Text(
                widget.lotteryType,
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: s(12),
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
              ),
              SizedBox(width: s(8)),
              Text(
                widget.prize,
                style: GoogleFonts.dmSans(
                  color: const Color(0xFFCFB95D),
                  fontSize: s(12),
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
              ),
              const Spacer(),
              _quickGuessButton(s),
            ],
          ),

          // EXACT 3PX SPACE AS REQUESTED
          SizedBox(height: s(3)),

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

          // The Rows (A B -, A C -, B C -)
          ...List.generate(widget.rows.length, (index) => _buildRow(index, s)),
        ],
      ),
    );
  }

  Widget _buildRow(int index, double Function(double) s) {
    return Padding(
      padding: EdgeInsets.only(bottom: s(10)),
      child: Row(
        children: [
          // Static letters (e.g., A and B)
          ...widget.rows[index].map((letter) => Padding(
            padding: EdgeInsets.only(right: s(10)),
            child: _box(letter, s),
          )),
          SizedBox(width: s(20),),
          // Selection boxes (dashes)
          _box(dashValues[index][0], s),
          SizedBox(width: s(10)),
          _box(dashValues[index][1], s),

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
        child: Text(
          'Quick Guess',
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontSize: s(12),
            fontWeight: FontWeight.w400,
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
            child: Text("-", style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(18))),
          ),
          Text("${quantities[index]}", style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(14))),
          GestureDetector(
            onTap: () => setState(() => quantities[index]++),
            child: Text("+", style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(18))),
          ),
        ],
      ),
    );
  }

  Widget _goldAddButton(int index, double Function(double) s) {
    return GestureDetector(
      onTap: () {
        if (dashValues[index].contains("-")) return;
        double price = double.tryParse(widget.ticketPrice.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
        widget.onAdd(widget.rows[index].join(""), dashValues[index].join(""), quantities[index], price);
      },
      child: Container(
        width: s(68),
        height: s(36),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // GRADIENT ADDED HERE
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
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
      width: s(68),
      height: s(36),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF313038), // Standard dark grey
        borderRadius: BorderRadius.circular(s(6)),
      ),
      child: Text(
        "Add",
        style: GoogleFonts.dmSans(
          color: Colors.white.withOpacity(0.5), // Faded text
          fontSize: s(14),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}