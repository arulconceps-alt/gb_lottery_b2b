import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/route_names.dart';
import 'package:gb_lottery_b2b/src/common/widgets/splashscreen.dart';

import 'package:go_router/go_router.dart';

class Routes {
  GoRouter router = GoRouter(
    initialLocation: "/",

    routes: [
      /// Splash
      GoRoute(
        name: RouteName.splashscreen,
        path: "/",
        builder: (context, state) => const SplashScreen(),
      ),
    ],
  );
}
