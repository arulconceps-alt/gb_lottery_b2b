import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:flutter/material.dart';

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
    required this.lotteryType,
    required this.prize,
    required this.ticketPrice,
    required this.rows,
    required this.onAdd,
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

  Widget _box(String text, {Color? color}) {
    final s = widget.s;
    return Container(
      width: s(34),
      height: s(34),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: color ?? const Color(0xFF313038),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s(6))),
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

  Widget _goldAddButton(int rowIndex) {
    final s = widget.s;
    return GestureDetector(
      onTap: () {
        double unitPrice = double.tryParse(
          widget.ticketPrice.replaceAll(RegExp(r'[^0-9.]'), ''),
        ) ?? 0.0;

        String combinedLetters = widget.rows[rowIndex].join("");
        String combinedValues = dashValues[rowIndex].join("");

        if (combinedValues.contains("-")) return;

        widget.onAdd(
          combinedLetters,
          combinedValues,
          quantities[rowIndex],
          unitPrice,
        );
      },
      child: Container(
        width: s(42),
        height: s(34),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(1.00, 0.50),
            end: Alignment(0.00, 0.50),
            colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s(6))),
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

  Widget _quantitySelector(int index) {
    final s = widget.s;
    return Container(
      width: s(84),
      height: s(34),
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
          Text(
            "${quantities[index]}",
            style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(14)),
          ),
          GestureDetector(
            onTap: () => setState(() => quantities[index]++),
            child: Text("+", style: TextStyle(color: Colors.white, fontSize: s(18))),
          ),
        ],
      ),
    );
  }

  Widget buildRow(int rowIndex, List<String> letters) {
    final s = widget.s;
    return Row(
      children: [
        for (var letter in letters) ...[_box(letter), SizedBox(width: s(8))],
        _box(dashValues[rowIndex][0]),
        SizedBox(width: s(8)),
        _box(dashValues[rowIndex][1]),
        const Spacer(),
        if (isQuickGuessClicked) ...[
          _quantitySelector(rowIndex),
          SizedBox(width: s(6)),
          _goldAddButton(rowIndex),
        ] else ...[
          Container(
            height: s(34),
            padding: EdgeInsets.symmetric(horizontal: s(10)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF313038),
              borderRadius: BorderRadius.circular(s(6)),
            ),
            child: Text(
              "Add",
              style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(14)),
            ),
          ),
        ],
      ],
    );
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
      decoration: ShapeDecoration(
        color: const Color(0xFF24232A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s(8))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.lotteryType,
                style: GoogleFonts.dmSans(color: Colors.white, fontSize: s(12)),
              ),
              SizedBox(width: s(8)),
              Text(
                widget.prize,
                style: GoogleFonts.dmSans(color: const Color(0xFFCFB95D), fontSize: s(12)),
              ),
              const Spacer(),
              _quickGuessButton(s),
            ],
          ),
          SizedBox(height: s(4)),
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
          for (int i = 0; i < widget.rows.length; i++) ...[
            buildRow(i, widget.rows[i]),
            SizedBox(height: s(10)),
          ],
        ],
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
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontSize: s(12),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}