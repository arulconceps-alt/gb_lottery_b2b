import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';
import 'package:gb_lottery_b2b/src/login/bloc/login_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFormCard extends StatefulWidget {
  final double scale;

  const LoginFormCard({super.key, required this.scale});

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  double s(double v) => v * widget.scale;

  late final TextEditingController _mobileController;
  late final TextEditingController _otpController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController(text: LoginState.initial.mobile);
    _otpController = TextEditingController(text: LoginState.initial.otp);
    _passwordController = TextEditingController(text: LoginState.initial.password);
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          context.pushReplacement('/dashboard');
        } else if (state.status == LoginStatus.failure && state.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          bloc.add(const ResetLoginMessage());
        } else if (state.status == LoginStatus.otpRequested) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP sent successfully')),
          );
          bloc.add(const ResetLoginMessage());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: s(20)),
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
                SizedBox(height: s(32)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.isOtpLogin ? "OTP Login" : "Password Login",
                      style: TextStyles.dmSans12SemiBold.copyWith(
                        fontSize: s(12),
                        fontWeight: FontWeight.w700,
                        color: ColorPalette.whitetext,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => bloc.add(ToggleLoginMode(!state.isOtpLogin)),
                      child: Text(
                        state.isOtpLogin ? "Switch to Password" : "Switch to OTP",
                        style: TextStyles.dmSans12.copyWith(
                          fontSize: s(12),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.primary,
                        ),
                      ),
                    ),
                  ],
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
                        style: TextStyles.dmSans12.copyWith(
                          fontSize: s(12),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.darktext,
                        ),
                      ),
                      SizedBox(width: s(10)),
                      Container(
                        width: 1,
                        height: s(22),
                        color: ColorPalette.darktext.withOpacity(0.4),
                      ),
                      SizedBox(width: s(10)),
                      Expanded(
                        child: TextField(
                          controller: _mobileController,
                          onChanged: (v) => bloc.add(UpdateMobileNumber(v)),
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: ColorPalette.whitetext),
                          decoration: InputDecoration(
                            hintText: "Enter Phone Number",
                            hintStyle: TextStyles.dmSans12.copyWith(
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

                state.isOtpLogin
                    ? _inputField(
                        iconPath: "assets/images/login/otp_icon.webp",
                        iconWidth: 16,
                        iconHeight: 16,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _otpController,
                                onChanged: (v) => bloc.add(UpdateOtpNumber(v)),
                                keyboardType: TextInputType.number,
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
                            GestureDetector(
                              onTap: state.status == LoginStatus.loading
                                  ? null
                                  : () => bloc.add(const RequestLoginOtp()),
                              child: Container(
                                height: s(36),
                                padding: EdgeInsets.symmetric(horizontal: s(14)),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorPalette.surface,
                                  borderRadius: BorderRadius.circular(s(10)),
                                ),
                                child: state.status == LoginStatus.loading
                                    ? SizedBox(
                                        height: s(12),
                                        width: s(12),
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "Get OTP",
                                        style: GoogleFonts.dmSans(
                                          fontSize: s(12),
                                          fontWeight: FontWeight.w700,
                                          color: ColorPalette.whitetext,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : _inputField(
                        iconPath: "assets/images/login/password_lock.webp",
                        iconWidth: 18,
                        iconHeight: 18,
                        child: TextField(
                          controller: _passwordController,
                          onChanged: (v) => bloc.add(UpdatePasswordString(v)),
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
                  onTap: state.status == LoginStatus.submitting
                      ? null
                      : () => bloc.add(const SubmitLoginCredentials()),
                  child: Container(
                    width: double.infinity,
                    height: s(60),
                    decoration: BoxDecoration(
                      gradient: ColorPalette.buttonGradient,
                      borderRadius: BorderRadius.circular(s(10)),
                    ),
                    child: Center(
                      child: state.status == LoginStatus.submitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Login",
                              style: TextStyles.dmSans16SemiBold.copyWith(
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
          SizedBox(height: s(20)),
        ],
      ),
    );
  },
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
