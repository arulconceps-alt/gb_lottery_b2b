part of 'add_customer_bloc.dart';

enum AddCustomerStatus { initial, loading, success, failure }

class AddCustomerState extends Equatable {
  final AddCustomerStatus status;
  final String selectedType;
  final List<CustomerModel> customers;
  final String message;

  final List<bool> expandedIndices;

  const AddCustomerState({
    required this.status,
    required this.selectedType,
    required this.customers,
    required this.message,
    required this.expandedIndices,
  });

  static final AddCustomerState initial = AddCustomerState(
    status: AddCustomerStatus.initial,
    selectedType: 'customer',
    customers: [CustomerModel.empty()],
    message: '',
    expandedIndices: const [false],
  );

  AddCustomerState copyWith({
    AddCustomerStatus Function()? status,
    String Function()? selectedType,
    List<CustomerModel> Function()? customers,
    String Function()? message,
    List<bool> Function()? expandedIndices,
  }) {
    return AddCustomerState(
      status: status != null ? status() : this.status,
      selectedType: selectedType != null ? selectedType() : this.selectedType,
      customers: customers != null ? customers() : this.customers,
      message: message != null ? message() : this.message,
      expandedIndices: expandedIndices != null ? expandedIndices() : this.expandedIndices,
    );
  }

  @override
  List<Object?> get props => [status, selectedType, customers, message, expandedIndices];
}
