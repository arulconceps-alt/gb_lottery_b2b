import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const CommonErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(s(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: Colors.redAccent,
              size: s(48),
            ),
            SizedBox(height: s(16)),
            Text(
              "Something went wrong",
              style: TextStyles.dmSans16SemiBold.copyWith(
                fontSize: s(16),
                color: ColorPalette.whitetext,
              ),
            ),
            SizedBox(height: s(8)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyles.dmSans12.copyWith(
                fontSize: s(12),
                color: ColorPalette.whitetext.withOpacity(0.7),
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: s(24)),
              GestureDetector(
                onTap: onRetry,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: s(24),
                    vertical: s(10),
                  ),
                  decoration: BoxDecoration(
                    gradient: ColorPalette.buttonGradient,
                    borderRadius: BorderRadius.circular(s(8)),
                  ),
                  child: Text(
                    "Retry",
                    style: TextStyles.dmSans14SemiBold.copyWith(
                      fontSize: s(14),
                      color: ColorPalette.whitetext,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
