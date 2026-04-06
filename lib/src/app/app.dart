import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/app_theme.dart';
import 'package:gb_lottery_b2b/src/app/routes.dart';

import 'package:responsive_framework/responsive_framework.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      // FIX 1: Global background color
      theme: AppTheme.theme,

      routerConfig: Routes.router,

      // FIX 2: Background inside ResponsiveFramework
      builder: (context, child) => Container(
        color: AppTheme.theme.scaffoldBackgroundColor,
        child: ResponsiveBreakpoints(
          child: child ?? const SizedBox(),
          breakpoints: const [
            Breakpoint(start: 0, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 800, name: TABLET),
            Breakpoint(start: 801, end: 1920, name: DESKTOP),
            Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    );
  }
}
