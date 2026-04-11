import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/add_customer/repo/add_customer_repository.dart';
import 'package:gb_lottery_b2b/src/common/models/customer_model.dart';
import 'package:logger/logger.dart';

part 'add_customer_event.dart';
part 'add_customer_state.dart';

class AddCustomerBloc extends Bloc<AddCustomerEvent, AddCustomerState> {
  AddCustomerBloc({required AddCustomerRepository repository})
      : _repository = repository,
        super(AddCustomerState.initial) {
    on<UpdateCustomerType>(_onUpdateType);
    on<AddFormEntry>(_onAddEntry);
    on<RemoveFormEntry>(_onRemoveEntry);
    on<UpdateFormEntry>(_onUpdateEntry);
    on<ToggleExpansion>(_onToggleExpansion);
    on<SubmitCustomers>(_onSubmit);
    on<ResetStatus>(_onResetStatus);
  }

  final AddCustomerRepository _repository;
  final _log = Logger();

  void _onUpdateType(UpdateCustomerType event, Emitter<AddCustomerState> emit) {
    // Update all customers in the list to have the same type
    final updatedCustomers = state.customers
        .map((c) => c.copyWith(type: event.type))
        .toList();
    emit(state.copyWith(
      selectedType: () => event.type,
      customers: () => updatedCustomers,
    ));
  }

  void _onAddEntry(AddFormEntry event, Emitter<AddCustomerState> emit) {
    final updatedCustomers = List<CustomerModel>.from(state.customers)
      ..add(CustomerModel.empty().copyWith(type: state.selectedType));
    final updatedExpanded = List<bool>.from(state.expandedIndices)..add(false);
    emit(state.copyWith(
      customers: () => updatedCustomers,
      expandedIndices: () => updatedExpanded,
    ));
  }

  void _onRemoveEntry(RemoveFormEntry event, Emitter<AddCustomerState> emit) {
    if (state.customers.length <= 1) return;
    final updatedCustomers = List<CustomerModel>.from(state.customers)
      ..removeAt(event.index);
    final updatedExpanded = List<bool>.from(state.expandedIndices)
      ..removeAt(event.index);
    emit(state.copyWith(
      customers: () => updatedCustomers,
      expandedIndices: () => updatedExpanded,
    ));
  }

  void _onToggleExpansion(ToggleExpansion event, Emitter<AddCustomerState> emit) {
    if (event.index >= state.expandedIndices.length) return;
    final updatedExpanded = List<bool>.from(state.expandedIndices);
    updatedExpanded[event.index] = !updatedExpanded[event.index];
    emit(state.copyWith(expandedIndices: () => updatedExpanded));
  }

  void _onUpdateEntry(UpdateFormEntry event, Emitter<AddCustomerState> emit) {
    if (event.index >= state.customers.length) return;

    final updatedCustomers = List<CustomerModel>.from(state.customers);
    updatedCustomers[event.index] = updatedCustomers[event.index].copyWith(
      name: event.name,
      phone: event.phone,
      pincode: event.pincode,
      email: event.email,
      address: event.address,
    );
    
    emit(state.copyWith(customers: () => updatedCustomers));
  }

  Future<void> _onSubmit(
    SubmitCustomers event,
    Emitter<AddCustomerState> emit,
  ) async {
    if (state.status == AddCustomerStatus.loading) return;

    _log.d('AddCustomerBloc::_onSubmit::Submitting ${state.customers.length} customers');
    try {
      emit(state.copyWith(status: () => AddCustomerStatus.loading));
      
      // Basic validation: Only Name and Phone are mandatory now
      for (var customer in state.customers) {
        final name = customer.name.trim();
        final phone = customer.phone.trim();
        
        if (name.isEmpty || phone.isEmpty) {
          throw Exception('Please fill Name and Phone for all entries');
        }
        
        // 10-digit phone validation
        if (phone.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
          throw Exception('Phone number must be exactly 10 digits for: $name');
        }
      }

      await _repository.addCustomers(state.customers);
      
      emit(state.copyWith(
        status: () => AddCustomerStatus.success,
        message: () => 'Agents added successfully',
      ));
    } catch (e) {
      _log.e('AddCustomerBloc::_onSubmit::Error: $e');
      emit(state.copyWith(
        status: () => AddCustomerStatus.failure,
        message: () => e.toString(),
      ));
    }
  }

  void _onResetStatus(ResetStatus event, Emitter<AddCustomerState> emit) {
    emit(state.copyWith(status: () => AddCustomerStatus.initial, message: () => ''));
  }
}
