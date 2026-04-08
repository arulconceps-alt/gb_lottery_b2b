class ApiConstants {
  const ApiConstants();

  final String API_BASE_URL = "http://187.127.131.80:4175/api";

  final String REQUEST_NAME = "requestname";
  final String DATA = "data";

  // --- Authentication ---
  final String login = "/dealer/otp/send";
  final String register = "/auth/register";
  final String logout = "/auth/logout";
  final String verifyOtp = "/auth/verify-otp";
  final String resendOtp = "/dealer/otp/send";
  final String refreshToken = "/auth/refresh-token";
  final String forgotPassword = "/auth/forgot-password";

  // --- User Profile ---
  final String getAccountDetails = "/account/details";
  final String updateProfile = "/account/update";
  final String changePassword = "/account/change-password";
  final String getKycStatus = "/kyc/status";
  final String submitKyc = "/kyc/submit";

  // --- Customers (B2B Management) ---
  final String getCustomersList = "/customers/list";
  final String getCustomerDetails = "/customers/details";
  final String addCustomer = "/customers/add";
  final String updateCustomer = "/customers/update";
  final String deleteCustomer = "/customers/delete";

  // --- Lottery & Games ---
  final String getCategories = "/categories";
  final String getGames = "/games";
  final String getGameDetails = "/games/details";
  final String getPromos = "/promos";

  // --- Cart & Checkout ---
  final String getCartItems = "/cart/items";
  final String addToCart = "/cart/add";
  final String updateCart = "/cart/update";
  final String removeFromCart = "/cart/remove";
  final String proceedToPay = "/pay";
  final String getSuccessMessage = "/success/message";

  // --- Purchase History ---
  final String getPurchaseHistory = "/purchase/history";
  final String getPurchaseDetails = "/purchase/details";

  // --- Results ---
  final String getResultsList = "/results/list";
  final String getResultDetails = "/results/details";

  // --- Wallet & Financials ---
  final String getWalletDetails = "/wallet/details";
  final String getWalletTransactions = "/wallet/transactions";
  final String withdraw = "/wallet/withdraw";
  final String addFunds = "/wallet/add-funds";
  final String getSettlements = "/settlements/list";

  // --- Dashboard & Analytics ---
  final String getDashboardStats = "/dashboard/stats";
  final String getCustomerGrowth = "/dashboard/customer-growth";
  final String getRevenueAnalytics = "/dashboard/revenue";
  final String getTopCustomers = "/dashboard/top-customers";

  // --- Notifications & Interaction ---
  final String getNotifications = "/notifications/list";
  final String markNotificationRead = "/notifications/mark-read";
  final String getLeaderboard = "/leaderboard";
  final String search = "/search";

  // --- Support & CMS ---
  final String getChatHistory = "/support/history";
  final String sendMessage = "/support/send";
  final String submitSuggestion = "/suggestions/submit";
  final String getTermsAndConditions = "/pages/terms";
  final String getPrivacyPolicy = "/pages/privacy-policy";
  final String getGamingsInfo = "/pages/responsible-gaming";

  // --- Legacy / Extra ---
  final String USER_HOME_LIST = "";
  final String USER_HOME_READ = "";

  //**************API Map********************
  final Map<String, String> API_MAP = const {
    "users": "users",
    "customers ": "customers",
  };
}
