import 'package:flutter/material.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
}

class AppSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        SnackBarType type = SnackBarType.success,
      }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      duration: const Duration(seconds: 3), // Slightly longer for gaming alerts
      content: _SnackBarContent(
        message: message,
        type: type,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class _SnackBarContent extends StatelessWidget {
  final String message;
  final SnackBarType type;

  const _SnackBarContent({
    required this.message,
    required this.type,
  });

  // --- THESE ARE THE MISSING GETTERS ---
  Color get bgColor {
    switch (type) {
      case SnackBarType.success:
        return const Color(0xFF2E7D32); // Deep Green
      case SnackBarType.error:
        return const Color(0xFFD32F2F); // Deep Red
      case SnackBarType.warning:
        return const Color(0xFFFFA000); // Amber/Orange
      case SnackBarType.info:
        return const Color(0xFF1976D2); // Blue
    }
  }

  IconData get icon {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_rounded;
      case SnackBarType.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.95), // Premium frosted look
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: const Icon(Icons.close, color: Colors.white70, size: 20),
          ),
        ],
      ),
    );
  }
}