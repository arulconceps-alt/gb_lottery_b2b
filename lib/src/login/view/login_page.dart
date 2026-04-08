import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/app/text_styles.dart';

import 'package:gb_lottery_b2b/src/common/services/services_locator.dart';
import 'package:gb_lottery_b2b/src/login/bloc/login_bloc.dart';
import 'package:gb_lottery_b2b/src/login/view/widgets/login_form_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: Scaffold(
        backgroundColor: ColorPalette.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: s(60)),

                /// Main Logo
                Image.asset(
                  "assets/images/login/logo.webp",
                  width: s(208),
                  height: s(102),
                ),

                SizedBox(height: s(27)),

                /// Title
                Text(
                  "Welcome Dealer",
                  style: TextStyles.dmSans18SemiBold.copyWith(
                    fontSize: s(26),
                    color: ColorPalette.whitetext,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: s(7)),

                /// Subtitle
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s(40)),
                  child: Text(
                    "Manage your lottery business, tickets, and\ncustomers in one place",
                    textAlign: TextAlign.center,
                    style: TextStyles.dmSans14.copyWith(
                      fontSize: s(14),
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.darktext,
                    ),
                  ),
                ),
                SizedBox(height: s(32)),

                LoginFormCard(scale: scale),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
