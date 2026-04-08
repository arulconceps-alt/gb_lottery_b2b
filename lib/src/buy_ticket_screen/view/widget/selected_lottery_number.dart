import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedLotteryNumber {
  final String label;
  final String price;
  final int quantity;

  SelectedLotteryNumber({
    required this.label,
    required this.price,
    required this.quantity,
  });
}

class MyNumberSummaryView extends StatelessWidget {
  final VoidCallback onClearAll;
  final List<SelectedLotteryNumber> selectedNumbers;
  final Function(int) onDeleteItem;

  const MyNumberSummaryView({
    super.key,
    required this.onClearAll,
    required this.selectedNumbers,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: h * 0.62,
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: const BoxDecoration(
        color:  ColorPalette.backgroundDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [

          _buildHeader(context), // Added context here
          SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 12,
                  runSpacing: 16,
                  children: List.generate(
                    selectedNumbers.length,
                        (index) =>
                        _buildExactNumberBox(context, index), // Added context
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 24),
          Text(
            'My Number',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () => showDeletePopup(context, onClearAll),
            child: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                "assets/images/buy_ticket/delete_icon.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExactNumberBox(BuildContext context, int index) {
    final item = selectedNumbers[index];

    return Stack(
      // We keep the Stack ONLY for the "X" button to float on the corner
      clipBehavior: Clip.none,
      children: [
        Container(
          // CHANGE: Removed fixed width: 114
          // ADDED: BoxConstraints to allow growing
          constraints: BoxConstraints(
            minWidth: 114, // Minimum size from Figma
            maxWidth: 200, // Safety limit so it doesn't hit the screen edge
          ),
          height: 34,
          padding: const EdgeInsets.only(left: 10, right: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF313038),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            // Use mainAxisSize.min so the Row only takes as much space as the text needs
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Label (A=5)
              Text(
                item.label,
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  letterSpacing: -0.18,
                ),
              ),

              const SizedBox(width: 8), // Added a bit more space for breathing

              // 2. Price (₹10.0)
              Text(
                item.price,
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  letterSpacing: -0.14,
                ),
              ),

              const SizedBox(width: 6),

              // 3. Quantity Badge (x1)
              Container(
                width: 18, // Slightly wider to handle "x10" or "x99"
                height: 16,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFCDB75D),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'x${item.quantity}',
                  style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    letterSpacing: -0.08,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Floating Close Button
        Positioned(
          top: -6,
          right: -6,
          child: GestureDetector(
            onTap: () => showDeletePopup(context, () => onDeleteItem(index)),
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.black, size: 10),
            ),
          ),
        ),
      ],
    );
  }
}

void showDeletePopup(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        // InsetPadding removes the default dialog margins that cause overflows
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          // Use constraints instead of fixed width to prevent overflow
          constraints: const BoxConstraints(maxWidth: 340),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: ShapeDecoration(
            color:  ColorPalette.backgroundDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Shrinks height to fit content
            children: [
              Text(
                'Delete',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: GoogleFonts.dmSans().fontFamily,
                  fontWeight: FontWeight.w600,
                  height: 1.30,
                  letterSpacing: -0.18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please confirm you want to clear all numbers?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: GoogleFonts.dmSans().fontFamily,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                  letterSpacing: -0.12,
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  // Use Expanded so buttons fill available space without overflowing
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF313038),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onConfirm();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          context.go('/'); // Or your home route
                        }
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
