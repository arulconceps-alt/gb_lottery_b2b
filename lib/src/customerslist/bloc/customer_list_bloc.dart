import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/common/models/customer_model.dart';
import 'package:gb_lottery_b2b/src/customerslist/repo/customer_list_repository.dart';
import 'package:logger/logger.dart';

part 'customer_list_event.dart';
part 'customer_list_state.dart';

class CustomerListBloc extends Bloc<CustomerListEvent, CustomerListState> {
  final CustomerListRepository _repository;
  final Logger _log = Logger();

  CustomerListBloc({required CustomerListRepository repository})
      : _repository = repository,
        super(CustomerListState.initial) {
    on<FetchCustomers>(_onFetchCustomers);
  }

  Future<void> _onFetchCustomers(
    FetchCustomers event,
    Emitter<CustomerListState> emit,
  ) async {
    emit(state.copyWith(status: () => CustomerListStatus.loading));

    try {
      final customers = await _repository.getCustomers(
        page: event.page,
        limit: event.limit,
      );

      emit(state.copyWith(
        status: () => CustomerListStatus.success,
        customers: () => customers,
        currentPage: () => event.page,
      ));
    } catch (e) {
      _log.e("CustomerListBloc::_onFetchCustomers::Error: $e");
      emit(state.copyWith(
        status: () => CustomerListStatus.failure,
        message: () => e.toString(),
      ));
    }
  }
}
