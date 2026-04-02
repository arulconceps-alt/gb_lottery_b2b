import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String iconLogo = "assets/images/splash/logo.webp";
  final String iconLogo = "assets/images/splash/logo.webp";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.go('/login'); 
    });
  }

  @override
  Widget build(BuildContext context) {
   final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: ColorPalette.background, 
      body: SafeArea(
        child: Center(
          child: Image.asset(
          child: Image.asset(
            iconLogo,
            width: s(167),
            height: s(82),
          ),
        ),
      ),
    );
  }
}
