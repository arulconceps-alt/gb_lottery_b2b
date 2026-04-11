part of 'customer_list_bloc.dart';

abstract class CustomerListEvent extends Equatable {
  const CustomerListEvent();

  @override
  List<Object?> get props => [];
}

class FetchCustomers extends CustomerListEvent {
  final int page;
  final int limit;
  final String? roleName;
  final String? search;

  const FetchCustomers({
    this.page = 1, 
    this.limit = 10,
    this.roleName,
    this.search,
  });

  @override
  List<Object?> get props => [page, limit, roleName, search];
}

class SearchChanged extends CustomerListEvent {
  final String query;
  const SearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}
