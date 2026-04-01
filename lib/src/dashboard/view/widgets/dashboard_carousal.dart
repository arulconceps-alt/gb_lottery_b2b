import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';

class DashboardCarousel extends StatefulWidget {
  const DashboardCarousel({super.key});

  @override
  State<DashboardCarousel> createState() => _DashboardCarouselState();
}

class _DashboardCarouselState extends State<DashboardCarousel> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<String> images = [
    "assets/images/dashboard/assam_lottry.webp",
    "assets/images/dashboard/top_kerala_lottry.webp",
    "assets/images/dashboard/nagaland_lottry.webp",
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_controller.hasClients) {
        _currentIndex++;

        if (_currentIndex >= images.length) {
          _currentIndex = 0;
        }

        _controller.animateToPage(
          _currentIndex,
          duration: Duration(
            milliseconds: (400 * (context.size?.width ?? 375) / 375).toInt(),
          ),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Column(
      children: [
        SizedBox(
          height: s(135),
          width: s(343),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: PageView.builder(
              controller: _controller,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                return Image.asset(images[index], fit: BoxFit.cover);
              },
            ),
          ),
        ),

        SizedBox(height: s(8)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: s(5),
              width: _currentIndex == index ? s(8) : s(5),

              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? ColorPalette.whitetext
                    : ColorPalette.darktext,
                borderRadius: BorderRadius.circular(s(4)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
