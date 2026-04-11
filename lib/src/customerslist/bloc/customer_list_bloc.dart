import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/common/models/customer_model.dart';
import 'package:gb_lottery_b2b/src/customerslist/repo/customer_list_repository.dart';
import 'package:logger/logger.dart';
import 'package:stream_transform/stream_transform.dart';

part 'customer_list_event.dart';
part 'customer_list_state.dart';

const _duration = Duration(milliseconds: 500);

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class CustomerListBloc extends Bloc<CustomerListEvent, CustomerListState> {
  final CustomerListRepository _repository;
  final Logger _log = Logger();
  Map<String, String> _rolesCache = {};

  CustomerListBloc({required CustomerListRepository repository})
      : _repository = repository,
        super(CustomerListState.initial) {
    on<FetchCustomers>(_onFetchCustomers);
    on<SearchChanged>(_onSearchChanged, transformer: debounce(_duration));
  }

  Future<void> _onFetchCustomers(
    FetchCustomers event,
    Emitter<CustomerListState> emit,
  ) async {
    final targetRole = event.roleName ?? state.selectedRole;
    final targetSearch = event.search ?? state.searchQuery;
    
    emit(state.copyWith(
      status: () => CustomerListStatus.loading,
      selectedRole: () => targetRole,
      searchQuery: () => targetSearch,
    ));

    try {
      if (targetRole == 'All') {
        // Since API doesn't support 'All', fetch both roles and combine results
        _log.d("CustomerListBloc::_onFetchCustomers::Fetching combined results (IDs: User, Moderator)");
        
        final results = await Future.wait([
          _repository.getCustomers(roleName: 'User', page: event.page, limit: event.limit, search: targetSearch),
          _repository.getCustomers(roleName: 'Moderator', page: event.page, limit: event.limit, search: targetSearch),
        ]);

        final List<CustomerModel> combinedList = [];
        int totalSum = 0;

        for (int i = 0; i < results.length; i++) {
          final res = results[i];
          _log.d("CustomerListBloc::_onFetchCustomers::Aggregating role ${i == 0 ? 'User' : 'Moderator'}: ${res.customers.length} items, total: ${res.total}");
          combinedList.addAll(res.customers);
          totalSum += res.total;
        }

        _log.d("CustomerListBloc::_onFetchCustomers::Combined results count: ${combinedList.length}, Total: $totalSum");

        emit(state.copyWith(
          status: () => CustomerListStatus.success,
          customers: () => combinedList,
          currentPage: () => event.page,
          totalCount: () => totalSum,
        ));
      } else {
        // Standard single role fetch
        _log.d("CustomerListBloc::_onFetchCustomers::Fetching role: $targetRole");
        final result = await _repository.getCustomers(
          roleName: targetRole,
          page: event.page,
          limit: event.limit,
          search: targetSearch,
        );
        _log.d("CustomerListBloc::_onFetchCustomers::Fetch result count: ${result.customers.length}, Total: ${result.total}");

        emit(state.copyWith(
          status: () => CustomerListStatus.success,
          customers: () => result.customers,
          currentPage: () => event.page,
          totalCount: () => result.total,
        ));
      }
    } catch (e) {
      _log.e("CustomerListBloc::_onFetchCustomers::Error: $e");
      emit(state.copyWith(
        status: () => CustomerListStatus.failure,
        message: () => e.toString(),
      ));
    }
  }

  void _onSearchChanged(SearchChanged event, Emitter<CustomerListState> emit) {
    add(FetchCustomers(page: 1, search: event.query));
  }
}
