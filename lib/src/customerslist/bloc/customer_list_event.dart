part of 'customer_list_bloc.dart';

abstract class CustomerListEvent extends Equatable {
  const CustomerListEvent();

  @override
  List<Object?> get props => [];
}

class FetchCustomers extends CustomerListEvent {
  final int page;
  final int limit;

  const FetchCustomers({this.page = 1, this.limit = 10});

  @override
  List<Object?> get props => [page, limit];
}
