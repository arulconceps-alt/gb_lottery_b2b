import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1E26), // same theme
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1E26),
        elevation: 0,
        title: Text(
          "Customers",
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