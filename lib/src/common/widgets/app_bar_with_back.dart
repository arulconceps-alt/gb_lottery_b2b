import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarWithBack extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onBackTap;

  const AppBarWithBack({super.key, this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return AppBar(
      backgroundColor: const Color(0xFF24232A),
      elevation: 0,
      leading: GestureDetector(
        onTap: onBackTap ?? () => context.pop(),
        child: Image.asset(
        "assets/images/dashboard/back.webp", 
        height: s(24),
        width: s(24),
      ),
      ),

      centerTitle: true,
      title: Image.asset(
        "assets/images/dashboard/gb_logo.webp", 
          height: s(22),
        width: s(31),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}