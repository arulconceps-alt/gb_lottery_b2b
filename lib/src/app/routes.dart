import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/route_names.dart';
import 'package:gb_lottery_b2b/src/common/widgets/bottom_navigation_bar.dart';
import 'package:gb_lottery_b2b/src/common/widgets/splashscreen.dart';
import 'package:gb_lottery_b2b/src/customers/view/customer_page.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/dashboard_page.dart';
import 'package:gb_lottery_b2b/src/login/view/login_page.dart';
import 'package:gb_lottery_b2b/src/profile/view/profile_page.dart';
import 'package:gb_lottery_b2b/src/results/view/result_page.dart';

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

      /// login
      GoRoute(
        name: RouteName.login,
        path: "/login",
        builder: (context, state) => const LoginPage(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return MainNavigationScreen(
            location: state.uri.toString(),
            child: child,
          );
        },

        routes: [
          /// dashboard
          GoRoute(
            name: RouteName.dashboard,
            path: "/dashboard",
            builder: (context, state) => const DashboardPage(),
          ),

          /// customer
          GoRoute(
            name: RouteName.customer,
            path: "/customer",
            builder: (context, state) => const CustomerPage(),
          ),

          /// results
          GoRoute(
            name: RouteName.results,
            path: "/results",
            builder: (context, state) => const ResultPage(),
          ),

          ///profile
          GoRoute(
            name: RouteName.profile,
            path: "/profile",
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}
