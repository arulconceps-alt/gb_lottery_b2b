part of 'customer_list_bloc.dart';

enum CustomerListStatus { initial, loading, success, failure }

class CustomerListState extends Equatable {
  final CustomerListStatus status;
  final List<CustomerModel> customers;
  final String message;
  final int currentPage;

  const CustomerListState({
    required this.status,
    required this.customers,
    required this.message,
    required this.currentPage,
  });

  static final CustomerListState initial = const CustomerListState(
    status: CustomerListStatus.initial,
    customers: [],
    message: '',
    currentPage: 1,
  );

  CustomerListState copyWith({
    CustomerListStatus Function()? status,
    List<CustomerModel> Function()? customers,
    String Function()? message,
    int Function()? currentPage,
  }) {
    return CustomerListState(
      status: status != null ? status() : this.status,
      customers: customers != null ? customers() : this.customers,
      message: message != null ? message() : this.message,
      currentPage: currentPage != null ? currentPage() : this.currentPage,
    );
  }

  @override
  List<Object?> get props => [status, customers, message, currentPage];
}
