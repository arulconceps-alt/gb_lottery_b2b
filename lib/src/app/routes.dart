import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/route_names.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/buy_ticket_screen.dart';
import 'package:gb_lottery_b2b/src/common/widgets/splashscreen.dart';
import 'package:gb_lottery_b2b/src/customer_info/view/customer_info_screen.dart';
import 'package:gb_lottery_b2b/src/myCart_Screen/view/myCart_screen.dart';
import 'package:gb_lottery_b2b/src/profile_screen/view/profile_screen.dart';
import 'package:gb_lottery_b2b/src/search_screen/view/search_screen.dart';

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
      /// OnBoarding
      GoRoute(
        name: RouteName.buy_ticket,
        path: "/buy_ticket",
        builder: (context, state) => const BuyTicketsScreen(),
      ),
      /// My Cart Screen
      GoRoute(
        name: RouteName.myCart,
        path: "/myCart",
        builder: (context, state) => const MycartScreen(),
      ),
      /// Profile Screen
      GoRoute(
        name: RouteName.profile,
        path: "/profile",
        builder: (context, state) => const ProfileScreen(),
      ),
      /// customer_info Screen
      GoRoute(
        name: RouteName.customer_info,
        path: "/customer_info",
        builder: (context, state) => const CustomerInfoScreen(),
      ),
      /// Search Screen
      GoRoute(
        name: RouteName.search_screen,
        path: "/search_screen",
        builder: (context, state) => const SearchScreen(),
      ),
    ],
  );
}
