part of 'add_customer_bloc.dart';

abstract class AddCustomerEvent extends Equatable {
  const AddCustomerEvent();

  @override
  List<Object?> get props => [];
}

class UpdateCustomerType extends AddCustomerEvent {
  final String type;
  const UpdateCustomerType(this.type);

  @override
  List<Object?> get props => [type];
}

class AddFormEntry extends AddCustomerEvent {
  const AddFormEntry();
}

class RemoveFormEntry extends AddCustomerEvent {
  final int index;
  const RemoveFormEntry(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateFormEntry extends AddCustomerEvent {
  final int index;
  final String? name;
  final String? phone;
  final String? pincode;
  final String? email;
  final String? address;

  const UpdateFormEntry({
    required this.index,
    this.name,
    this.phone,
    this.pincode,
    this.email,
    this.address,
  });

  @override
  List<Object?> get props => [index, name, phone, pincode, email, address];
}

class ToggleExpansion extends AddCustomerEvent {
  final int index;
  const ToggleExpansion(this.index);

  @override
  List<Object?> get props => [index];
}

class SubmitCustomers extends AddCustomerEvent {
  const SubmitCustomers();
}

class ResetStatus extends AddCustomerEvent {
  const ResetStatus();
}
