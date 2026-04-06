import 'package:gb_lottery_b2b/src/add_customer/view/add_customer_page.dart';
import 'package:gb_lottery_b2b/src/app/route_names.dart';
import 'package:gb_lottery_b2b/src/common/widgets/bottom_navigation_bar.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/buy_ticket_screen.dart';
import 'package:gb_lottery_b2b/src/common/widgets/splashscreen.dart';
import 'package:gb_lottery_b2b/src/customer_information/view/customer_information_page.dart';
import 'package:gb_lottery_b2b/src/customerslist/view/customer_list_page.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/dashboard_page.dart';
import 'package:gb_lottery_b2b/src/leaderboard/view/leaderboard_page.dart';
import 'package:gb_lottery_b2b/src/login/view/login_page.dart';
import 'package:gb_lottery_b2b/src/login/view/login_screen.dart';
import 'package:gb_lottery_b2b/src/notification_screen/view/notification_screen.dart';
import 'package:gb_lottery_b2b/src/onboarding/view/onboarding.dart';
import 'package:gb_lottery_b2b/src/otp/view/otp_page.dart';
import 'package:gb_lottery_b2b/src/profile/view/profile_page.dart';
import 'package:gb_lottery_b2b/src/purchase_history_details/view/purchase_history_details.dart';
import 'package:gb_lottery_b2b/src/purchase_history_list_screen/view/purchase_history_list.dart';
import 'package:gb_lottery_b2b/src/resultinner/view/result_inner_page.dart';
import 'package:gb_lottery_b2b/src/customer_edit/view/customer_edit_screen.dart';
import 'package:gb_lottery_b2b/src/myCart_Screen/view/myCart_screen.dart';
import 'package:gb_lottery_b2b/src/edit_profile_screen/view/edit_profile_screen.dart';
import 'package:gb_lottery_b2b/src/results/view/resluts_page.dart';
import 'package:gb_lottery_b2b/src/search_screen/view/search_screen.dart';
import 'package:gb_lottery_b2b/src/settlement/view/settlement_page.dart';
import 'package:gb_lottery_b2b/src/wallet_screen/view/wallet_screen.dart';

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
      /// 
      GoRoute(
        name: RouteName.onboarding,
        path: "/onboarding",
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        name: RouteName.login,
        path: "/login",
        builder: (context, state) => const LoginPage(),
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

      /// Purchase list
        GoRoute(
        name: RouteName.purchase_history_list,
        path: "/purchase_history_list",
        builder: (context, state) => const PurchaseHistoryList(),
      ),

      /// Purchase History details Screen
      GoRoute(
        name: RouteName.purchase_history_details,
        path: "/purchase_history_details",
        builder: (context, state) => const PurchaseHistoryDetails(),
      ),

      /// Wallet Screen
      GoRoute(
        name: RouteName.wallet_screen,
        path: "/wallet_screen",
        builder: (context, state) => const WalletScreen(),
      ),

      /// notification_screen
      GoRoute(
        name: RouteName.notification_screen,
        path: "/notification_screen",
        builder: (context, state) => const NotificationScreen(),
      ),

      /// settlement
       GoRoute(
        name: RouteName.settlement,
        path: "/settlement",
        builder: (context, state) => const SettlementPage(),
      ),

      ///reslutinner
       GoRoute(
        name: RouteName.reslutinner,
        path: "/reslutinner",
        builder: (context, state) => const ResultInnerPage(),
      ),

      /// leaderboard
      GoRoute(
        name: RouteName.leaderboard,
        path: "/leaderboard",
        builder: (context, state) => const LeaderboardPage(),
      ),
    ],
  );
}
