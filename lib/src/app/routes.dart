import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/add_customer/view/add_customer_page.dart';
import 'package:gb_lottery_b2b/src/app/route_names.dart';
import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/repos/preferences_repository.dart';
import 'package:gb_lottery_b2b/src/common/services/services_locator.dart';
import 'package:gb_lottery_b2b/src/common/constants/constansts.dart';
import 'package:gb_lottery_b2b/src/common/repos/preferences_repository.dart';
import 'package:gb_lottery_b2b/src/common/services/services_locator.dart';
import 'package:gb_lottery_b2b/src/common/widgets/bottom_navigation_bar.dart';
import 'package:gb_lottery_b2b/src/buy_ticket_screen/view/buy_ticket_screen.dart';
import 'package:gb_lottery_b2b/src/common/widgets/splashscreen.dart';
import 'package:gb_lottery_b2b/src/customer_information/view/customer_information_page.dart';
import 'package:gb_lottery_b2b/src/customerslist/view/customer_list_page.dart';
import 'package:gb_lottery_b2b/src/dashboard/view/dashboard_page.dart';
import 'package:gb_lottery_b2b/src/dashboard_chart_screen/view/dashboard_chart_screen.dart';
import 'package:gb_lottery_b2b/src/leaderboard/view/leaderboard_page.dart';
import 'package:gb_lottery_b2b/src/login/view/login_page.dart';
import 'package:gb_lottery_b2b/src/notification_screen/view/notification_screen.dart';
import 'package:gb_lottery_b2b/src/onboarding/view/onboarding.dart';
import 'package:gb_lottery_b2b/src/otp/view/otp_page.dart';
import 'package:gb_lottery_b2b/src/privacy/view/privacy_page.dart';
import 'package:gb_lottery_b2b/src/profile/view/profile_page.dart';
import 'package:gb_lottery_b2b/src/purchase_history_details/view/purchase_history_details.dart';
import 'package:gb_lottery_b2b/src/purchase_history_list_screen/view/purchase_history_list.dart';
import 'package:gb_lottery_b2b/src/relation_manager/view/relation_manager_page.dart';
import 'package:gb_lottery_b2b/src/responsible/view/responsible_gaming_page.dart';
import 'package:gb_lottery_b2b/src/resultinner/view/result_inner_page.dart';
import 'package:gb_lottery_b2b/src/customer_edit/view/customer_edit_screen.dart';
import 'package:gb_lottery_b2b/src/myCart_Screen/view/myCart_screen.dart';
import 'package:gb_lottery_b2b/src/profile/view/edit_profile_page.dart';
import 'package:gb_lottery_b2b/src/results/view/resluts_page.dart';
import 'package:gb_lottery_b2b/src/search_screen/view/search_screen.dart';
import 'package:gb_lottery_b2b/src/settlement/view/settlement_page.dart';
import 'package:gb_lottery_b2b/src/terms_codition/view/terms_condition_page.dart';
import 'package:gb_lottery_b2b/src/transaction_screen/view/transaction_screen.dart';
import 'package:gb_lottery_b2b/src/wallet_screen/view/wallet_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    refreshListenable: getIt<PreferencesRepository>(),
    routes: [
      /// Splash
      GoRoute(
        name: RouteName.splashscreen,
        path: "/",
        builder: (context, state) => const SplashScreen(),
      ),

      /// login
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
          GoRoute(
            name: RouteName.editprofile,
            path: "/editprofile",
            builder: (context, state) => const EditProfilePage(),
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

      /// Dashboard Chart Design
      GoRoute(
        name: RouteName.dashboard_chart,
        path: "/dashboard_chart",
        builder: (context, state) => const DashboardChartScreen(),
      ),
      GoRoute(
        name: RouteName.relationmanager,
        path: "/relationmanager",
        builder: (context, state) => const RelationManagerPage(),
      ),
      GoRoute(
        name: RouteName.responsiblegaming,
        path: "/responsiblegaming",
        builder: (context, state) => const ResponsibleGamingPage(),
      ),
      GoRoute(
        name: RouteName.privacy,
        path: "/privacy",
        builder: (context, state) => const PrivacyPage(),
      ),
      GoRoute(
        name: RouteName.terms,
        path: "/terms",
        builder: (context, state) => const TermsAndConditionsPage(),
      ),
      /// Transaction Screen
      GoRoute(
        name: RouteName.transaction,
        path: "/transaction",
        builder: (context, state) => const TransactionScreen(),
      ),
    ],
    redirect: (context, state) {
      final prefRepo = getIt<PreferencesRepository>();
      final dynamic token = prefRepo.getPreference(Constants.store.AUTH_TOKEN);
      final bool isLoggedIn = token != null && token.toString().isNotEmpty;
      final String location = state.matchedLocation;

      // Debugging
      print("🚀 Router Check: Location=$location, isLoggedIn=$isLoggedIn");

      final bool isAuthPath =
          location == '/login' ||
          location == '/' ||
          location == '/onboarding' ||
          location == '/otp';

      if (!isLoggedIn) {
        // If not logged in and not on a login/landing page, force redirect
        if (!isAuthPath) {
          print("🚫 Unauthorized access -> Redirection to /login");
          return '/login';
        }
        return null;
      }

      // If logged in and on a login/landing page, go to dashboard
      if (isAuthPath) {
        print("✅ Already logged in -> Redirection to /dashboard");
        return '/dashboard';
      }

      return null;
    },
  );
}
