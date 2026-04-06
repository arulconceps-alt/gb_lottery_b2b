import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<String> images = [
    "assets/images/onboarding/onboarding1.webp",
    "assets/images/onboarding/onboarding1.webp",
    "assets/images/onboarding/onboarding1.webp",
  ];

  final List<String> titles = [
    "Play Smart,\nWin Real Money.",
    "Play Smart,\nWin Real Money.",
    "Play Smart,\nWin Real Money.",
  ];

  final List<String> subtitles = [
    "Pick your favorite game, enter the contest, and place your bet with confidence. Simple, fast, and secure.",
    "Pick your favorite game, enter the contest, and place your bet with confidence. Simple, fast, and secure.",
    "Pick your favorite game, enter the contest, and place your bet with confidence. Simple, fast, and secure.",
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 360;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1116),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: PageView.builder(
              controller: _controller,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              }, 
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      height: s(544),
                      width: s(359),
                      child: Image.asset(
                        images[index],
                        height: s(544),
                        width: s(359),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.9, 1.0],
                          colors: [Colors.transparent, const Color(0xFF0F1116)],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: s(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titles[currentIndex],
                    style: GoogleFonts.dmSans(
                      fontSize: s(32),
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.whitetext,
                    ),
                  ),

                  SizedBox(height: s(10)),

                  Text(
                    subtitles[currentIndex],
                    style: GoogleFonts.dmSans(
                      fontSize: s(12),
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.whitetext.withValues(alpha: .80),
                    ),
                  ),

                  SizedBox(height: s(13)),

                  Row(
                    children: List.generate(
                      images.length,
                      (index) => Container(
                        margin: EdgeInsets.only(right: s(2)),
                        width: currentIndex == index ? s(24) : s(6),
                        height: s(6),
                        decoration: BoxDecoration(
                          color:  ColorPalette.whitetext,
                          borderRadius: BorderRadius.circular(s(10)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: s(41)),
                  GestureDetector(
                    onTap: () {
                      if (currentIndex < images.length - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      } else {
                        context.push('/login');
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: s(60),
                      decoration: BoxDecoration(
                        gradient: ColorPalette.buttonGradient,
                        borderRadius: BorderRadius.circular(s(9.58)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        currentIndex == images.length - 1
                            ? "Get Started"
                            : "Next",
                        style: GoogleFonts.dmSans(
                          fontSize: s(16),
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.whitetext,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: s(20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
