import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/add_customer/view/add_customer_page.dart';
import 'package:gb_lottery_b2b/src/app/route_names.dart';
import 'package:gb_lottery_b2b/src/common/widgets/bottom_navigation_bar.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/buy_ticket_screen.dart';
import 'package:gb_lottery_b2b/src/common/widgets/splashscreen.dart';
import 'package:gb_lottery_b2b/src/customer_information/view/customer_information_page.dart';
import 'package:gb_lottery_b2b/src/customers/view/customer_page.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/dashboard_page.dart';
import 'package:gb_lottery_b2b/src/login/view/login_screen.dart';
import 'package:gb_lottery_b2b/src/otp/view/otp_page.dart';
import 'package:gb_lottery_b2b/src/profile/view/profile_page.dart';
import 'package:gb_lottery_b2b/src/resultinner/view/result_inner_page.dart';
import 'package:gb_lottery_b2b/src/customer_info/view/customer_info_screen.dart';
import 'package:gb_lottery_b2b/src/myCart_Screen/view/myCart_screen.dart';
import 'package:gb_lottery_b2b/src/edit_profile_screen/view/edit_profile_screen.dart';
import 'package:gb_lottery_b2b/src/results/view/resluts_page.dart';
import 'package:gb_lottery_b2b/src/search_screen/view/search_screen.dart';
import 'package:gb_lottery_b2b/src/settlement/view/settlement_page.dart';

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
        builder: (context, state) => const LoginScreen(),
      ),
       GoRoute(
        name: RouteName.otp,
        path: "/otp",
        builder: (context, state) => const OtpPage(),
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
      GoRoute(
        name: RouteName.addcustomer,
        path: "/addcustomer",
        builder: (context, state) => const AddCustomerPage(),
      ),
       GoRoute(
        name: RouteName.customerinformation,
        path: "/customerinformation",
        builder: (context, state) => const CustomerInformationPage(),
      ),
    
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
        name: RouteName.editprofile,
        path: "/editprofile",
        builder: (context, state) => const EditProfileScreen(),
      ),
      /// customer_info Screen
      GoRoute(
        name: RouteName.customer_edit,
        path: "/customer_edit",
        builder: (context, state) => const CustomerEditScreen(),
      ),
      /// Search Screen
      GoRoute(
        name: RouteName.search_screen,
        path: "/search_screen",
        builder: (context, state) => const SearchScreen(),
      ),
       GoRoute(
        name: RouteName.settlement,
        path: "/settlement",
        builder: (context, state) => const SettlementPage(),
      ),
       GoRoute(
        name: RouteName.reslutinner,
        path: "/reslutinner",
        builder: (context, state) => const ResultInnerPage(),
      ),
    ],
  );
}
