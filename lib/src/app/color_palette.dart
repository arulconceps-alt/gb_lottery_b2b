import 'package:flutter/material.dart';

class ColorPalette {
  // Backgrounds - Figma dark theme
  static const Color background = Color(0xFF1C1B20); // splash Screen Fill
  static const Color surface = Color(0xFF313038); // Rectangle 39515 Fill
  static const Color surfaceVariant = Color(0xFF413E3D); // BG Color Fill
  static const Color surfaceDark = Color(0xFF333236); // Ellipse 6065 Fill
  static const Color whitetext = Color(0xFFFFFFFF);
  static const Color darktext = Color(0xFF9F9F9F);
  static const Color primary = Color(0xFFDFC55C);


  static const Color snackbar = Color(0xFF37B158);

  // static const LinearGradient primaryGradient = LinearGradient(
  //   colors: [primary, Color(0xFFE8D88A)],
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  // );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFFA89A5F), Color(0xFFDFC55C)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static Widget buildLuxGlow(
    Alignment alignment,
    Color color, {
    double size = 400,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }

  static Color white(double alpha) => Colors.white.withValues(alpha: alpha);
  static Color black(double alpha) => Colors.black.withValues(alpha: alpha);
}
