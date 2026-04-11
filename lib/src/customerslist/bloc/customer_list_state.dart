part of 'customer_list_bloc.dart';

enum CustomerListStatus { initial, loading, success, failure }

class CustomerListState extends Equatable {
  final CustomerListStatus status;
  final List<CustomerModel> customers;
  final String message;
  final int currentPage;
  final int totalCount;
  final String selectedRole; 
  final String searchQuery;

  const CustomerListState({
    required this.status,
    required this.customers,
    required this.message,
    required this.currentPage,
    required this.totalCount,
    required this.selectedRole,
    required this.searchQuery,
  });

  static const CustomerListState initial = CustomerListState(
    status: CustomerListStatus.initial,
    customers: [],
    message: '',
    currentPage: 1,
    totalCount: 0,
    selectedRole: 'All',
    searchQuery: '',
  );

  CustomerListState copyWith({
    CustomerListStatus Function()? status,
    List<CustomerModel> Function()? customers,
    String Function()? message,
    int Function()? currentPage,
    int Function()? totalCount,
    String Function()? selectedRole,
    String Function()? searchQuery,
  }) {
    return CustomerListState(
      status: status != null ? status() : this.status,
      customers: customers != null ? customers() : this.customers,
      message: message != null ? message() : this.message,
      currentPage: currentPage != null ? currentPage() : this.currentPage,
      totalCount: totalCount != null ? totalCount() : this.totalCount,
      selectedRole: selectedRole != null ? selectedRole() : this.selectedRole,
      searchQuery: searchQuery != null ? searchQuery() : this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    status, 
    customers, 
    message, 
    currentPage, 
    totalCount, 
    selectedRole, 
    searchQuery
  ];
}
