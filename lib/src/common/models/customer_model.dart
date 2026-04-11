import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String? pincode;
  final String? email;
  final String? address;
  final String type; // 'customer' or 'moderator'
  final String? roleId;

  const CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    this.pincode,
    this.email,
    this.address,
    required this.type,
    this.roleId,
  });

  CustomerModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? pincode,
    String? email,
    String? address,
    String? type,
    String? roleId,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      pincode: pincode ?? this.pincode,
      email: email ?? this.email,
      address: address ?? this.address,
      type: type ?? this.type,
      roleId: roleId ?? this.roleId,
    );
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? json['full_name']?.toString() ?? json['username']?.toString() ?? 'Unknown',
      phone: json['phone']?.toString() ?? json['mobile']?.toString() ?? json['phoneNumber']?.toString() ?? '',
      pincode: json['pincode']?.toString(),
      email: json['email']?.toString(),
      address: json['address']?.toString(),
      type: json['type']?.toString() ?? 'customer',
      roleId: json['roleId']?.toString() ?? 
              (json['role'] is Map ? (json['role']['_id'] ?? json['role']['id'])?.toString() : json['role']?.toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      "name": name,
      "phone": phone,
    };
    if (email != null && email!.isNotEmpty) map["email"] = email;
    if (pincode != null && pincode!.isNotEmpty) map["pincode"] = pincode;
    if (address != null && address!.isNotEmpty) map["address"] = address;
    if (roleId != null && roleId!.isNotEmpty) map["roleId"] = roleId;
    
    return map;
  }

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
  List<Object?> get props => [id, name, phone, pincode, email, address, type, roleId];
}
