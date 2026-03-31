import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1E26), // same theme
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1E26),
        elevation: 0,
        title: Text(
          "Results",
          style: GoogleFonts.inter(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text(
          "Coming Soon",
          style: GoogleFonts.inter(
            fontSize: 18,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}