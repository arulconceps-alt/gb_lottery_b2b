import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFormCard extends StatefulWidget {
  final double scale;

  const LoginFormCard({super.key, required this.scale});

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  bool isOtpLogin = true;

  double s(double v) => v * widget.scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric( horizontal: s(20)),
      decoration: BoxDecoration(
        color: ColorPalette.backgroundDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(s(20)),
          topRight: Radius.circular(s(20)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(
          //   height: s(60),
          //   padding: EdgeInsets.all(s(11)),
          //   decoration: BoxDecoration(
          //     color: ColorPalette.background,
          //     borderRadius: BorderRadius.circular(s(10)),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () => setState(() => isOtpLogin = true),
          //           child: Container(
          //             decoration: BoxDecoration(
          //               gradient: isOtpLogin
          //                   ? ColorPalette.buttonGradient
          //                   : null,
          //               borderRadius: BorderRadius.circular(s(10)),
          //             ),
          //             child: Center(
          //               child: Text(
          //                 "OTP Login",
          //                 style: GoogleFonts.dmSans(
          //                   fontSize: s(12),
          //                   fontWeight: FontWeight.w700,
          //                   color: ColorPalette.whitetext,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () => setState(() => isOtpLogin = false),
          //           child: Container(
          //             decoration: BoxDecoration(
          //               gradient: !isOtpLogin
          //                   ? ColorPalette.buttonGradient
          //                   : null,
          //               borderRadius: BorderRadius.circular(s(10)),
          //             ),
          //             child: Center(
          //               child: Text(
          //                 "Password Login",
          //                 style: GoogleFonts.dmSans(
          //                   fontSize: s(12),
          //                   fontWeight: FontWeight.w700,
          //                   color: ColorPalette.whitetext,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: s(32)),
           Text(
                  "OTP Login",
                  style: GoogleFonts.dmSans(
                    fontSize: s(12),
                    fontWeight: FontWeight.w700,
                    color: ColorPalette.whitetext,
                  ),
                ),

          SizedBox(height: s(12)),

          _inputField(
            iconPath: "assets/images/login/fa_mobile.webp",
            iconWidth: 18,
            iconHeight: 18,
            child: Row(
              children: [
                Text(
                  "+91",
                  style: GoogleFonts.dmSans(
                    fontSize: s(12),
                    fontWeight: FontWeight.w400,
                    color: ColorPalette.darktext,
                  ),
                ),

                SizedBox(width: s(10)),

                /// Divider
                Container(
                  width: 1,
                  height: s(22),
                  color: ColorPalette.darktext.withOpacity(0.4),
                ),

                SizedBox(width: s(10)),

                Expanded(
                  child: TextField(
                    style: TextStyle(color: ColorPalette.whitetext),
                    decoration: InputDecoration(
                      hintText: "Enter Phone Number",
                      hintStyle: GoogleFonts.dmSans(
                        fontSize: s(12),
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.darktext,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: s(16)),

          isOtpLogin
              ? _inputField(
                  iconPath: "assets/images/login/otp_icon.webp",
                  iconWidth: 16,
                  iconHeight: 16,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: ColorPalette.whitetext),
                          decoration: InputDecoration(
                            hintText: "Enter OTP",
                            hintStyle: GoogleFonts.dmSans(
                              fontSize: s(12),
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.darktext,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      SizedBox(width: s(10)),

                      /// Get OTP
                      Container(
                        height: s(36),
                        padding: EdgeInsets.symmetric(horizontal: s(14)),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorPalette.surface,
                          borderRadius: BorderRadius.circular(s(10)),
                        ),
                        child: Text(
                          "Get OTP",
                          style: GoogleFonts.dmSans(
                            fontSize: s(12),
                            fontWeight: FontWeight.w700,
                            color: ColorPalette.whitetext,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              /// PASSWORD FIELD
              : _inputField(
                  iconPath: "assets/images/login/password_lock.webp",
                  iconWidth: 18,
                  iconHeight: 18,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(color: ColorPalette.whitetext),
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      hintStyle: GoogleFonts.dmSans(
                        fontSize: s(12),
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.darktext,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
          SizedBox(height: s(76)),
          GestureDetector(
            onTap: () => context.push('/dashboard'),
            child: Container(
              width: double.infinity,
              height: s(60),
              decoration: BoxDecoration(
                gradient: ColorPalette.buttonGradient,
                borderRadius: BorderRadius.circular(s(10)),
              ),
              child: Center(
                child: Text(
                  "Login",
                  style: GoogleFonts.dmSans(
                    fontSize: s(16),
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.whitetext,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: s(23)),

          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      "By clicking this button you confirm that you have read and agree to\nthe",
                  style: GoogleFonts.dmSans(
                    color: ColorPalette.darktext,
                    fontSize: s(10),
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: "Terms and Conditions",
                  style:  GoogleFonts.dmSans(
                    height: 1.4,
                    color: ColorPalette.primary,
                    fontSize: s(10),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: " and ",
                  style:  GoogleFonts.dmSans(
                    color: ColorPalette.darktext,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    fontSize: s(10),
                  ),
                ),
                TextSpan(
                  text: "privacy policy",
                  style:  GoogleFonts.dmSans(
                    color: ColorPalette.primary,
                    fontSize: s(10),
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: " of the company and\nconfirm that you are legal age.",
                  style:  GoogleFonts.dmSans(
                    color: ColorPalette.darktext,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    fontSize: s(10),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: s(58)),
        ],
      ),
    );
  }

  Widget _inputField({
    required Widget child,
    required String iconPath,
    double? iconWidth,
    double? iconHeight,
  }) {
    return Container(
      height: s(60),
      padding: EdgeInsets.symmetric(horizontal: s(20)),
      decoration: BoxDecoration(
        color: ColorPalette.backgroundDark,
        borderRadius: BorderRadius.circular(s(12)),
        border: Border.all(
          color: ColorPalette.surface,
          width: 1
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Icon
          Image.asset(
            iconPath,
            width: s(iconWidth ?? 18),
            height: s(iconHeight ?? 18),
            fit: BoxFit.contain,
          ),

          SizedBox(width: s(12)),

          /// Content
          Expanded(child: child),
        ],
      ),
    );
  }
}
