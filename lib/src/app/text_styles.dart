import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  // --- DM Sans font styles ---
  static TextStyle dmSans8 = GoogleFonts.dmSans(
    fontSize: 8,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle dmSans10 = GoogleFonts.dmSans(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle dmSans10SemiBold = GoogleFonts.dmSans(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle dmSans12 = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle dmSans12SemiBold = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle dmSans12Bold = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle dmSans12SemiBoldItalic = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  );

  static TextStyle dmSans14 = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle dmSans14SemiBold = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle dmSans14Bold = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle dmSans15 = GoogleFonts.dmSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle dmSans15SemiBold = GoogleFonts.dmSans(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle dmSans16 = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle dmSans16SemiBold = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle dmSans16Bold = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle dmSans18 = GoogleFonts.dmSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle dmSans18SemiBold = GoogleFonts.dmSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // --- Primary-linked styles (Gold) ---
  static TextStyle dmSans16Primary = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: const Color(0xFFDFC55C),
  );

  static TextStyle dmSans10Primary = GoogleFonts.dmSans(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: const Color(0xFFDFC55C),
  );

  // --- Inter font styles ---
  static TextStyle inter7Bold = GoogleFonts.inter(
    fontSize: 7,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle inter8Bold = GoogleFonts.inter(
    fontSize: 8,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle inter9 = GoogleFonts.inter(
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle inter10 = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle inter12 = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle inter12SemiBold = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle inter12Italic = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  );

  static TextStyle inter13 = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle inter14 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle inter14SemiBold = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle inter16 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle inter16SemiBold = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle inter16SemiBoldItalic = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  );

  static TextStyle inter18 = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle inter18SemiBold = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // --- Erotique Trial fallback ---
  static TextStyle erotiqueTrial24 = GoogleFonts.ebGaramond(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle erotiqueTrial32 = GoogleFonts.ebGaramond(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  // --- Helper methods for colored variants ---
  static TextStyle dmSans14WithColor(Color color) =>
      dmSans14.copyWith(color: color);
  static TextStyle dmSans16WithColor(Color color) =>
      dmSans16.copyWith(color: color);
  static TextStyle inter14WithColor(Color color) =>
      GoogleFonts.inter(fontSize: 14, color: color);
  static TextStyle inter16WithColor(Color color) =>
      inter16.copyWith(color: color);
  static TextStyle dmSans14Primary(BuildContext context) =>
      dmSans14.copyWith(color: Theme.of(context).colorScheme.primary);
      
  // --- Theme Syncing ---
  static void updateFromTheme(ThemeData theme) {
    final color = theme.textTheme.bodyLarge?.color ?? Colors.white;
    final primary = theme.colorScheme.primary;

    dmSans8 = dmSans8.copyWith(color: color);
    dmSans10 = dmSans10.copyWith(color: color);
    dmSans10SemiBold = dmSans10SemiBold.copyWith(color: color);
    dmSans12 = dmSans12.copyWith(color: color);
    dmSans12SemiBold = dmSans12SemiBold.copyWith(color: color);
    dmSans12Bold = dmSans12Bold.copyWith(color: color);
    dmSans12SemiBoldItalic = dmSans12SemiBoldItalic.copyWith(color: color);
    dmSans14 = dmSans14.copyWith(color: color);
    dmSans14SemiBold = dmSans14SemiBold.copyWith(color: color);
    dmSans14Bold = dmSans14Bold.copyWith(color: color);
    dmSans15 = dmSans15.copyWith(color: color);
    dmSans15SemiBold = dmSans15SemiBold.copyWith(color: color);
    dmSans16 = dmSans16.copyWith(color: color);
    dmSans16SemiBold = dmSans16SemiBold.copyWith(color: color);
    dmSans16Bold = dmSans16Bold.copyWith(color: color);
    dmSans18 = dmSans18.copyWith(color: color);
    dmSans18SemiBold = dmSans18SemiBold.copyWith(color: color);

    dmSans16Primary = dmSans16Primary.copyWith(color: primary);
    dmSans10Primary = dmSans10Primary.copyWith(color: primary);

    inter7Bold = inter7Bold.copyWith(color: color);
    inter8Bold = inter8Bold.copyWith(color: color);
    inter9 = inter9.copyWith(color: color);
    inter10 = inter10.copyWith(color: color);
    inter12 = inter12.copyWith(color: color);
    inter12SemiBold = inter12SemiBold.copyWith(color: color);
    inter12Italic = inter12Italic.copyWith(color: color);
    inter13 = inter13.copyWith(color: color);
    inter14 = inter14.copyWith(color: color);
    inter14SemiBold = inter14SemiBold.copyWith(color: color);
    inter16 = inter16.copyWith(color: color);
    inter16SemiBold = inter16SemiBold.copyWith(color: color);
    inter16SemiBoldItalic = inter16SemiBoldItalic.copyWith(color: color);
    inter18 = inter18.copyWith(color: color);
    inter18SemiBold = inter18SemiBold.copyWith(color: color);

    erotiqueTrial24 = erotiqueTrial24.copyWith(color: color);
    erotiqueTrial32 = erotiqueTrial32.copyWith(color: color);
  }
}
