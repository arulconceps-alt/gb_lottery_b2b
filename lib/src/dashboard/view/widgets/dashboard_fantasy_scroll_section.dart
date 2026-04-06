import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashboardFantasyScrollSection extends StatefulWidget {
  const DashboardFantasyScrollSection({super.key});

  @override
  State<DashboardFantasyScrollSection> createState() =>
      _DashboardFantasyScrollSectionState();
}

class _DashboardFantasyScrollSectionState
    extends State<DashboardFantasyScrollSection> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  bool isUserScrolling = false;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 20), (_) {
      if (!isUserScrolling && _scrollController.hasClients) {
        double next = _scrollController.offset + 0.8;

        if (next >= _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(next);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final itemWidth = s(140);
    final spacing = s(12);

    final images = [
      "assets/images/dashboard/icc.webp",
      "assets/images/dashboard/ipl.webp",
      "assets/images/dashboard/hocky.webp",
    ];

    final messages = ["hi", "hello", "like it"];

    return SizedBox(
      height: s(66),
      child: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.idle) {
            isUserScrolling = false;
          } else {
            isUserScrolling = true;
          }
          return true;
        },
        child: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: images.length * 20,
          separatorBuilder: (_, __) => SizedBox(width: spacing),
          itemBuilder: (context, index) {
            final actualIndex = index % images.length;
            final image = images[actualIndex];

            return GestureDetector(
              onTap: () {
                final actualIndex = index % images.length;
                final messages = ["hi", "hello", "like it"];

                final messenger = ScaffoldMessenger.maybeOf(context);

                messenger?.showSnackBar(
                  SnackBar(content: Text(messages[actualIndex])),
                );
              },
              child: _card(image, itemWidth, s),
            );
          },
        ),
      ),
    );
  }

  // 🔹 CARD (unchanged UI)
  Widget _card(String image, double width, double Function(double) s) {
    return Container(
      width: width,
      height: s(66),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(s(12)),
        color: Colors.black,
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(image, fit: BoxFit.cover),
    );
  }
}
