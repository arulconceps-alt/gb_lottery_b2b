import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String pincode;
  final String? email;
  final String? address;
  final String type; // 'customer' or 'moderator'

  const CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.pincode,
    this.email,
    this.address,
    required this.type,
  });

  CustomerModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? pincode,
    String? email,
    String? address,
    String? type,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      pincode: pincode ?? this.pincode,
      email: email ?? this.email,
      address: address ?? this.address,
      type: type ?? this.type,
    );
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? json['full_name']?.toString() ?? json['username']?.toString() ?? 'Unknown',
      phone: json['phone']?.toString() ?? json['mobile']?.toString() ?? json['phoneNumber']?.toString() ?? '',
      pincode: json['pincode'] ?? '',
      email: json['email'],
      address: json['address'],
      type: json['type'] ?? 'customer',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "pincode": pincode,
        "email": email,
        "address": address,
        "type": type,
      };

  factory CustomerModel.empty() {
    return CustomerModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '',
      phone: '',
      pincode: '',
      email: '',
      address: '',
      type: 'customer',
    );
  }

  @override
  List<Object?> get props => [id, name, phone, pincode, email, address, type];
}
