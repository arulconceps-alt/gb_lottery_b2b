import 'package:dio/dio.dart';
import 'package:gb_lottery_b2b/src/lottery/repo/lottery_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gb_lottery_b2b/src/common/repos/api_repository.dart';
import 'package:gb_lottery_b2b/src/common/repos/preferences_repository.dart';
import 'package:gb_lottery_b2b/src/login/repo/login_repository.dart';
import 'package:gb_lottery_b2b/src/login/bloc/login_bloc.dart';
import 'package:gb_lottery_b2b/src/add_customer/repo/add_customer_repository.dart';
import 'package:gb_lottery_b2b/src/add_customer/bloc/add_customer_bloc.dart';
import 'package:gb_lottery_b2b/src/profile/repo/profile_repository.dart';
import 'package:gb_lottery_b2b/src/profile/bloc/profile_bloc.dart';
import 'package:gb_lottery_b2b/src/lottery/bloc/lottery_bloc.dart';
import 'package:gb_lottery_b2b/src/customerslist/repo/customer_list_repository.dart';
import 'package:gb_lottery_b2b/src/customerslist/bloc/customer_list_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Core
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<PreferencesRepository>(
    () => PreferencesRepository(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<ApiRepository>(
    () => ApiRepository(getIt<Dio>(), getIt<PreferencesRepository>()),
  );

  // Repositories
  getIt.registerLazySingleton<LoginRepository>(
    () =>
        LoginRepository(getIt<ApiRepository>(), getIt<PreferencesRepository>()),
  );
  getIt.registerLazySingleton<AddCustomerRepository>(
    () => AddCustomerRepository(getIt<ApiRepository>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(
      getIt<ApiRepository>(),
      getIt<PreferencesRepository>(),
    ),
  );
  getIt.registerLazySingleton<LotteryRepository>(
    () => LotteryRepository(getIt<ApiRepository>()),
  );
  getIt.registerLazySingleton<CustomerListRepository>(
    () => CustomerListRepository(getIt<ApiRepository>()),
  );

  // Blocs
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(repository: getIt<LoginRepository>()),
  );
  getIt.registerFactory<AddCustomerBloc>(
    () => AddCustomerBloc(repository: getIt<AddCustomerRepository>()),
  );
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(repository: getIt<ProfileRepository>()),
  );
  getIt.registerFactory<LotteryBloc>(
    () => LotteryBloc(getIt<LotteryRepository>()),
  );
  getIt.registerFactory<CustomerListBloc>(
    () => CustomerListBloc(repository: getIt<CustomerListRepository>()),
  );
}
